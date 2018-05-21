class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.text :message
      t.string :type
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
