class CreatePeopleAttributes < ActiveRecord::Migration
  def self.up
    create_table :people_attributes do |t|
      t.string :people_id                                                         
      t.string :value                                                       
      t.string :people_attribute_type_id
      t.string :creator                                                         
      t.boolean :voided  
 
      t.timestamps
    end
  end

  def self.down
    drop_table :people_attributes
  end
end
