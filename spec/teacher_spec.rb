require 'rspec'
require 'date'
require 'faker'
require_relative '../app/models/teacher'


describe Teacher, "name" do 
  
  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:teachers).should be_true
    Teacher.delete_all
  
    @teacher = Teacher.new
    @teacher.assign_attributes(
      :first_name => Faker::Name.name,
      :last_name => Faker::Name.name,
      :email => Faker::Internet.email,
      :phone => Faker::PhoneNumber.phone_number
    )
  end
  
  it "should have a name method" do
    @teacher.should respond_to :name 
  end

  it "should concatenate first and last name" do
    @teacher.name.should == "#{@teacher.first_name} #{@teacher.last_name}"
  end
  
  
end

describe Teacher, "validations" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:students).should be_true
    Teacher.delete_all
  end

  before(:each) do
    @teacher = Teacher.new
    @teacher.assign_attributes(
      :first_name => Faker::Name.name,
      :last_name => Faker::Name.name,
      :email => Faker::Internet.email,
      :phone => Faker::PhoneNumber.phone_number
    )
  end

  it "should accept valid info" do
    @teacher.should be_valid
  end

  it "should accept valid emails" do
    ["joe@example.com", "info@bbc.co.uk", "bugs@devbootcamp.com"].each do |address|
      @teacher.assign_attributes(:email => address)
      @teacher.should be_valid
    end
  end

  it "shouldn't allow two teachers with the same email" do
    another_teacher = Teacher.create!(
      :first_name => Faker::Name.name,
      :last_name => Faker::Name.name,
      :email => @teacher.email,
      :phone => Faker::PhoneNumber.phone_number
    )
    @teacher.should_not be_valid
  end


end
