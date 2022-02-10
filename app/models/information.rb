class Information < ApplicationRecord

  enum role_id: { :admin => 1, :hr => 2 , :pm => 3, :employee => 4 }

  belongs_to :user
end
