class CreateTweets < ActiveRecord::Migration
  def self.up 
    create_table :tweets do |t|
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

    execute "ALTER TABLE tweets MODIFY status_id bigint(20) DEFAULT 0 NOT NULL;"
    execute "ALTER TABLE tweets MODIFY from_user_id bigint(20) DEFAULT 0 NOT NULL;"
    execute "ALTER TABLE tweets MODIFY to_user_id bigint(20) DEFAULT NULL NULL;"

    add_index :tweets, [:status_id], :name => 'IX_tweets_status_id', :unique => true
    add_index :tweets, [:created_at], :name => 'IX_tweets_created_at'
  end

  def self.down
    remove_index :tweets, :created_at
    drop_table :tweets
  end
end
