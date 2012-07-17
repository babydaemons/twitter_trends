class CreateAcquisitions < ActiveRecord::Migration
  def self.up 
    create_table :acquisitions do |t|
      t.integer :status_id, :null => false
      t.datetime :created_at, :null => false
      t.integer :from_user_id, :null => false
      t.string :from_user, :null => false
      t.integer :to_user_id, :null => true
      t.string :to_user, :null => true
      t.string :iso_language_code, :null => false
      t.string :profile_image_url, :null => false
      t.string :source, :null => false
      t.text :text, :null => false

      t.timestamps
    end

    execute "ALTER TABLE acquisitions MODIFY status_id bigint(20) DEFAULT 0 NOT NULL;"
    execute "ALTER TABLE acquisitions MODIFY from_user_id bigint(20) DEFAULT 0 NOT NULL;"
    execute "ALTER TABLE acquisitions MODIFY to_user_id bigint(20) DEFAULT NULL NULL;"

    add_index :acquisitions, [:status_id], :name => 'IX_acquisitions_status_id', :unique => true
  end

  def self.down
    remove_index :acquisitions, :status_id
    drop_table :acquisitions
  end
end
