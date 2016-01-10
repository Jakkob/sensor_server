class CreateLumen < ActiveRecord::Migration
  def change
    create_table :lumen do |t|
    	t.integer :data, null: false
      t.timestamps null: false
    end
  end
end
