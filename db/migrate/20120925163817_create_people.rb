class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.date :birthdate
      t.string :gender
      t.string :creator
      t.boolean :voided

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
