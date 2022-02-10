class Information < ApplicationRecord

  enum role_id: { :admin => 1, :hr => 2 , :pm => 3, :employee => 4 }
  belongs_to :user
  validates :name, presence: true
  validates :address, presence: true
  validates :date_of_birth, presence: true
  validates :phone, presence: true
  validates :role_id, presence: true
end
