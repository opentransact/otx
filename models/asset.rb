class Asset < ActiveRecord::Base
  validates :transaction_url,       :presence => true, :uniqueness => true, :url => true
  validates :oauth_consumer_key,    :presence => true, :uniqueness => true
  validates :oauth_consumer_secret, :presence => true
  validates :asset_url,                                                     :url => true, :allow_blank => true

  scope :verified, where(:verified => true)

  after_save :verify

  private

  def verify
    # TODO: run discovery
  end
end