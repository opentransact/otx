class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      # state for state machine managing business rules
      t.string :state, :null=>false, :default=>"pending"

      # url of offered asset
      t.string :offered_url, :null=>false
      t.integer :offered_amount, :null=>false
      # url of wanted asset
      t.string :wanted_url, :null=>false
      t.integer :wanted_amount, :null=>false

      # Optional redirect url for redirecting user somewhere after offer is created
      t.string :redirect_url

      t.timestamp :expires, :offered_at, :cancelled_at, :closed_at
      # authentication token for offererer

      t.string :offer_token, :null=>false
      t.timestamps

    end

    add_index :offers, :offered_url
    add_index :offers, :wanted_url
  end

  def self.down
    drop_table :offers
  end
end
