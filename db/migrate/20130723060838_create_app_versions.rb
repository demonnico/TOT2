class CreateAppVersions < ActiveRecord::Migration
  def change
    create_table :app_versions do |t|
      t.string :app_name
      t.string :version
      t.string :short_version
      t.integer :beta_version
      t.string :icon_url
      t.datetime :release_date
      t.text :change_log

      t.timestamps
    end

    add_index :app_versions, :beta_version,             :unique => true
    add_index :app_versions, :app_name,                 :unique => true
    add_index :app_versions, :version,                  :unique => true
    add_index :app_versions, :short_version,            :unique => true
    add_index :app_versions, :release_date,             :unique => true
  end
end
