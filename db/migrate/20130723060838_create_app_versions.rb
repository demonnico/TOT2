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
  end
end
