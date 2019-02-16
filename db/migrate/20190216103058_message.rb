class Message < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text_message
      t.string :urlsafe
      t.integer :visits_remaining
      t.string :encryption_key

      t.timestamps
    end
  end
end
