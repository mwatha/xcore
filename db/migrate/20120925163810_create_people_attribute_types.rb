class CreatePeopleAttributeTypes < ActiveRecord::Migration
  def self.up
    create_table :people_attribute_types do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :people_attribute_types
  end
end
