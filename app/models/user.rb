class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :users_projects
  has_many :projects, through: :users_projects

  has_one :information

  has_one :users_department
  has_one :department, through: :users_department


  accepts_nested_attributes_for :information

  def with_information
    build_information if information.nil?
    self
  end

  def free?
    department.blank?
  end
end
