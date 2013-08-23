require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class CreateStudents < ActiveRecord::Migration
  def change
     create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.belongs_to :teacher
      t.string :gender
      t.string :email
      t.string :phone
      t.date :birthday
    end
  end
  
  def up
    add_column :students, :name, :string
    add_column :students, :address, :string
    Student.each do |student|
      student.update_attributes! :name => student.first_name + " " + student.last_name
    end
    remove_column :students, :first_name
    remove_column :students, :last_name
  end

  def down
    add_column :first_name, :last_name
    Student.each do |student|
      student.update_attributes! :first_name => student.name.split(" ")[0]
      student.update_attributes! :last_name => student.name.split(" ")[1]
    end
    remove_column :name
  end
end
