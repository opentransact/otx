class Asset < ActiveRecord::Base
  validates :transaction_url,       :presence => true, :uniqueness => true, :url => true
  validates :oauth_consumer_key,    :presence => true, :uniqueness => true
  validates :oauth_consumer_secret, :presence => true
  validates :assets_url, :url => {:allow_nil => true}

  def verified?
    false # TODO
  end
end