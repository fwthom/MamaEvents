module Admin
  class DocumentsController < Admin::ApplicationController
    def download_options_xlsx
    p = Axlsx::Package.new
    event = Event.find(params[:id])
    orders = event.orders
    p.workbook.add_worksheet(name: "Sample") do |sheet|
      sheet.add_row ["Nom", "Prénom", "Option", "Quantité", "Statut de la participation", "Date de création"]
      orders.each do |order|
        sheet.add_row [order.participation.participant.last_name, order.participation.participant.first_name, order.option.name, order.quantity, order.participation.status, order.created_at]
      end
    end
    # Send the file as a response
    formatted_date = Date.today.strftime('%Y_%m_%d')
    formatted_event_name = event.name.parameterize(separator: '_')
    # Send the file as a response
    send_data p.to_stream.read,
              filename: "options_#{formatted_event_name}_#{formatted_date}.xlsx",
              type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
              disposition: 'attachment'
    end

    def download_bib_numbers_xlsx
      p = Axlsx::Package.new
      event = Event.find(params[:id])
      participations = event.participations
      p.workbook.add_worksheet(name: "Sample") do |sheet|
        sheet.add_row ["Évènement", "Nom", "Prénom", "Ticket", "Numéro de dossard", "Statut de la participation", "Date de création"]
        participations.each do |participation|
          sheet.add_row [event.name, participation.participant.last_name, participation.participant.first_name, participation.ticket.name,participation.bib_number, participation.status, participation.created_at]
        end
      end
      formatted_date = Date.today.strftime('%Y_%m_%d')
      formatted_event_name = event.name.parameterize(separator: '_')

      # Send the file as a response
      send_data p.to_stream.read,
                filename: "dossards_#{formatted_event_name}_#{formatted_date}.xlsx",
                type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                disposition: 'attachment'
    end
  end
end