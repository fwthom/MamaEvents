module Admin
  class DocumentsController < Admin::ApplicationController
    def download_options_xlsx
    p = Axlsx::Package.new
    event = Event.find(params[:id])
    orders = event.orders
    p.workbook.add_worksheet(name: "Sample") do |sheet|
      sheet.add_row ["Nom", "Prénom", "Option", "Quantité"]
      orders.each do |order|
        sheet.add_row [order.participation.participant.last_name, order.participation.participant.first_name, order.option.name, order.quantity]
      end
    end
    # Send the file as a response
    send_data p.to_stream.read,
              filename: "generated_document.xlsx",
              type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
              disposition: 'attachment'
    end
  end
end