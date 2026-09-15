class AddKeysToTables < ActiveRecord::Migration[8.0]
  def change

    add_index :bikes, :customer_id
    add_index :repairs, :bike_id
    add_index :repairs, :employee_id
    add_index :repair_services, :repair_id
    add_index :repair_services, :service_id

    add_foreign_key :bikes, :customers
    add_foreign_key :repairs, :bikes
    add_foreign_key :repairs, :employees
    add_foreign_key :repair_services, :repairs
    add_foreign_key :repair_services, :services
  end
end
