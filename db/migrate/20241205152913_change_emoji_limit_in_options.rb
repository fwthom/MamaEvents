class ChangeEmojiLimitInOptions < ActiveRecord::Migration[7.1]
  def change
    change_column :options, :emoji, :string, limit: 10
  end
end
