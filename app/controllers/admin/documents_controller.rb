module Admin
  class DocumentsController < Admin::ApplicationController
    def download_xlsx
    p = Axlsx::Package.new
    event = Event.find(params[:id])
    p.workbook.add_worksheet(name: "Sample") do |sheet|
      sheet.add_row [event.name, "Header 2", "Header 3"]
      sheet.add_row ["Value 1", "Value 2", "Value 3"]
    end
    # Send the file as a response
    send_data p.to_stream.read,
              filename: "generated_document.xlsx",
              type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
              disposition: 'attachment'
    end
  end
end