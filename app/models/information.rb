class Information < ApplicationRecord

  enum role: { :admin => 1, :hr => 2 , :employee => 3 }

  belongs_to :user

  validates :name, presence: true
  validates :address, presence: true
  validates :date_of_birth, presence: true
  validates :phone, presence: true
  validates :role, presence: true

end
