class CreateRepairs < ActiveRecord::Migration[8.0]
  def change
    create_table :repairs do |t|
      t.bigint :bike_id, null: false
      t.bigint :employee_id
      t.string :state, null: false, default: "Received"
      t.date :promised_on
      t.datetime :handed_back_at
      t.string :customer_answer
      t.timestamps
    end
  end
end
