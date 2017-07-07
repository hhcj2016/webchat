class UpdateToMessages < ActiveRecord::Migration[5.0]
  def change

    rename_column :messages, :conversation_id, :chat_id

  end
end
