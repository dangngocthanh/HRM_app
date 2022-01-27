class CreateRoles < ActiveRecord::Migration[7.0]

  def change
    create_table :roles do |t|
      t.column :name, :string
      t.timestamps
    end
  end
end
