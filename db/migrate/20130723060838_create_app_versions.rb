class CreateAppVersions < ActiveRecord::Migration
  def change
    create_table  :app_versions do |t|
      t.integer   :beta_version,              :null => false, :default => 0
      t.string    :app_name,                  :null => false, :default => ""
      t.string    :version,                   :null => false, :default => ""
      t.string    :short_version,             :null => false, :default => ""
      t.datetime  :release_date
      t.text      :change_log,                :null => false, :default => ""
      t.string    :ipa_path,                  :null => false
      t.string    :dsym_path
      t.string    :icon_path
      t.string    :itunes_artwork_path
      t.string    :uploader_email,            :null => false, :default => "unknown email"

      t.integer   :app_id,                    :null => false #foreign key

      t.timestamps
    end

    add_index :app_versions, :beta_version,             :unique => false
    add_index :app_versions, :app_name,                 :unique => false
    add_index :app_versions, :version,                  :unique => false
    add_index :app_versions, :short_version,            :unique => false
    add_index :app_versions, :release_date,             :unique => false
    add_index :app_versions, :app_id,                   :unique => false
  end
end
