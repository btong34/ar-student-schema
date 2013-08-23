require_relative '../../db/config'

class Teacher < ActiveRecord::Base
  has_many :students 

  validates :email, uniqueness: true 

  def name
    "#{first_name} #{last_name}"
  end

end
