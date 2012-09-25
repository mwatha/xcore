class CreatePeopleNames < ActiveRecord::Migration
  def self.up
    create_table :people_names do |t|
      t.string :people_id                                                        
      t.string :first_name                                                          
      t.string :middle_name                                                          
      t.string :last_name                                                          
      t.string :creator                                                         
      t.boolean :voided 

      t.timestamps
    end
  end

  def self.down
    drop_table :people_names
  end
end
