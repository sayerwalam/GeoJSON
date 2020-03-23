class CreatePoints < ActiveRecord::Migration[6.0]
  def self.up
   create_table :points do |t|
     t.json :json
     t.timestamps
   end
 end

 def self.down
   drop_table :points
 end
end
