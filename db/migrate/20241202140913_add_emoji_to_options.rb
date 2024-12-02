class AddEmojiToOptions < ActiveRecord::Migration[7.1]
  def change
    add_column :options, :emoji, :string, limit: 1
  end
end
