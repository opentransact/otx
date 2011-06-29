class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :transaction_url, :null => false
      t.string :oauth_consumer_key, :null => false
      t.string :oauth_consumer_secret, :null => false
      t.string :assets_url
    end

    add_index :assets, :transaction_url, :unique => true
    add_index :assets, :oauth_consumer_key, :unique => true
  end

  def self.down
    drop_table :assets
  end
end
