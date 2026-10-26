class AddWorkshopFieldsToUsersAndRepairs < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string, null: false, default: "counter"
    add_reference :users, :employee, null: true, foreign_key: true
    add_index :users, :employee_id, unique: true, name: "index_users_on_employee_id_unique"

    add_reference :repairs, :taken_in_by, null: true, foreign_key: { to_table: :users }
  end
end
