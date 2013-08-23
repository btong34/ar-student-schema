require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class UpdateFullnames < ActiveRecord::Migration

  def up
    add_column :students, :name, :string
    add_column :students, :address, :string
    Student.all.each do |student|
      student.update_attributes! :name => student.first_name + " " + student.last_name
    end
    remove_column :students, :first_name
    remove_column :students, :last_name
  end

  def down
    add_column :first_name, :last_name
    Student.all.each do |student|
      student.update_attributes! :first_name => student.name.split(" ")[0]
      student.update_attributes! :last_name => student.name.split(" ")[1]
    end
    remove_column :name
  end

end