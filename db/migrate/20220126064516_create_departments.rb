class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end
