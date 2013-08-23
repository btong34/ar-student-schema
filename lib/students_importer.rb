require_relative '../app/models/student'


module StudentsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/students.csv")
    field_names = nil
    Student.transaction do
      File.open(filename).each do |line|
        data = line.chomp.split(',')
        if field_names.nil?
          field_names = data
        else
          attribute_hash = Hash[field_names.zip(data)]
          student = Student.create!(attribute_hash)
        end
      end
    end
  end

  def self.assign_teacher
    Student.transaction do
      Student.find_each(:batch_size => 6) do |student|
        student.update_attributes(
          :teacher_id => rand(9) + 1 
        )
      end
    end
  end

end
