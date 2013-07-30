class CreateAppVersions < ActiveRecord::Migration
  def change
    create_table :app_versions do |t|
      t.string :app_name,                   :null => false, :default => ""
      t.string :version,                    :null => false, :default => ""
      t.string :short_version,              :null => false, :default => ""
      t.integer :beta_version,              :null => false, :default => 0
      t.string :icon_url,                   :null => false, :default => ""
      t.datetime :release_date
      t.text :change_log,                   :null => false, :default => ""

      t.timestamps
    end

    add_index :app_versions, :beta_version,             :unique => true
    add_index :app_versions, :app_name,                 :unique => true
    add_index :app_versions, :version,                  :unique => true
    add_index :app_versions, :short_version,            :unique => true
    add_index :app_versions, :release_date,             :unique => true
  end
end
