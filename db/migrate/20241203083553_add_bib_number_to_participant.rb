class AddBibNumberToParticipant < ActiveRecord::Migration[7.1]
  def change
    add_column :participants, :bib_number, :integer
  end
end
