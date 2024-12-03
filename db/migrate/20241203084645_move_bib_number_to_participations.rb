class MoveBibNumberToParticipations < ActiveRecord::Migration[7.1]
  def change
    remove_column :participants, :bib_number, :integer
    add_column :participations, :bib_number, :integer
  end
end
