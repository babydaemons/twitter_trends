class CreateHits < ActiveRecord::Migration
  def self.up
    create_table :hits do |t|
      t.integer :status_id
      t.integer :keyword_id
      t.timestamps
    end

    execute "ALTER TABLE hits MODIFY status_id bigint(20) DEFAULT 0 NOT NULL;"
    execute "ALTER TABLE hits MODIFY keyword_id bigint(20) DEFAULT 0 NOT NULL;"

    add_index :hits, [:keyword_id, :created_at], :name => 'IX_hits_keyword_id_created_at'
  end
end
