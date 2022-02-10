class CreateInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :information do |t|
      t.bigint :user_id
      t.string :name
      t.string :address
      t.datetime :date_of_birth
      t.string :phone
      t.boolean :has_department, default: false
      t.bigint :role_id
      t.foreign_key :users, index: true, foreign_key: true
      t.foreign_key :roles, index: true, foreign_key: true
      t.timestamps
    end
  end
end
