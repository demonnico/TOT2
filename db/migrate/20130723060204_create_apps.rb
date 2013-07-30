class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :bundle_id,              :null => false, :default => ""
      t.integer :last_version,          :null => false, :default => 0

      t.timestamps
    end

	add_index :apps, :bundle_id,	:unique => true
  end
end
