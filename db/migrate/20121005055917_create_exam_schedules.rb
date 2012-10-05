class CreateExamSchedules < ActiveRecord::Migration
  def self.up
    create_table :exam_schedules do |t|
      t.string :program_id
      t.string :subject_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :creator
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :exam_schedules
  end
end
