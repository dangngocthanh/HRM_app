class CreateRoles < ActiveRecord::Migration[7.0]

  def change
    create_table :roles do |t|
      t.column :name, :string
      t.timestamps
    end

    Role.create :name => "admin"
    Role.create :name => "hr"
    Role.create :name => "pm"
    Role.create :name => "employee"
  end

end
