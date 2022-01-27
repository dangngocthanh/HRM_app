class CreateRoles < ActiveRecord::Migration[7.0]

  def change
    create_table :roles do |t|
      t.column :name, :string
      t.timestamps
      end

      Role.create :name => "Admin"
      Role.create :name => "HR"
      Role.create :name => "PM"
      Role.create :name => "Employee"
  end

end
