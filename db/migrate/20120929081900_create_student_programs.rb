class CreateStudentPrograms < ActiveRecord::Migration
  def self.up
    create_table :student_programs do |t|
      t.string :people_id
      t.string :program_id
      t.date :date_enrolled
      t.date :end_date
      t.string :creator
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :student_programs
  end
end
