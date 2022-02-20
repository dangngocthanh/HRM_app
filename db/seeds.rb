# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
movies = User.create(:email => 'Admin@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Admin', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0999999999', :role=> 1})
movies = User.create(:email => 'HR@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'HR', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0888888888', :role => 2})
movies = User.create(:email => 'Dev1@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev1', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0777777777', :role=> 3})
movies = User.create(:email => 'Dev2@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev2', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0166666666', :role => 3})
movies = User.create(:email => 'Dev3@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev3', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0266666666', :role => 3})
movies = User.create(:email => 'Dev4@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev4', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0366666666', :role => 3})
movies = User.create(:email => 'Dev5@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev5', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0466666666', :role => 3})
movies = User.create(:email => 'Dev6@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev6', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0566666666', :role => 3})
movies = User.create(:email => 'Dev7@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev7', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0666666666', :role => 3})
movies = User.create(:email => 'Dev8@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev8', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0766666666', :role => 3})
movies = User.create(:email => 'Dev9@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev9', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0866666666', :role => 3})
movies = User.create(:email => 'Dev10@gmail.com', :password => '123456', :password_confirmation => '123456', :information_attributes => {:name => 'Dev10', :address => 'Ha Noi', :date_of_birth => '09/12/2003', :phone => '0966666666', :role => 3})