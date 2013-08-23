require_relative '../../db/config'

class Student < ActiveRecord::Base

  validates :email, uniqueness: true, format: { with: /\w{1,}@\w{1,}\.\w{2,}/ }
  validates_inclusion_of :age, in: 6..110
  validates_length_of :phone, minimum: 10,
                      tokenizer: ->(str) { str.scan(/\d/) }
  
  belongs_to :teacher, :foreign_key => "teacher_id"

  attr_accessor :age

  def name
    "#{first_name} #{last_name}"
  end
  

  def age
    now = Date.today
    self.age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end

end
