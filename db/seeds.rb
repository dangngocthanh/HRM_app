# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
movies = User.create(:email => 'Admin@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Admin', :address => '15', :date_of_birth => '09/12/2003', :phone => '0999999999', :role_id => 1})
movies = User.create(:email => 'HR@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'HR', :address => '15', :date_of_birth => '09/12/2003', :phone => '0888888888', :role_id => 2})
movies = User.create(:email => 'Dev1@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev1', :address => '15', :date_of_birth => '09/12/2003', :phone => '0777777777', :role_id => 4})
movies = User.create(:email => 'Dev2@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev2', :address => '15', :date_of_birth => '09/12/2003', :phone => '0666666666', :role_id => 4})