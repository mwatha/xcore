class CreateProgramsSubjectsRelationships < ActiveRecord::Migration
  def self.up
    create_table :programs_subjects_relationships do |t|
      t.string :program_id
      t.string :subject_id
      t.string :creator
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :programs_subjects_relationships
  end
end
