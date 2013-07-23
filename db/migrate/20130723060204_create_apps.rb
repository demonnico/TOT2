class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :bundle_id
      t.integer :last_version

      t.timestamps
    end
  end
end
