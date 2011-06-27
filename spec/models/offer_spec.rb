require "spec_helper"

describe Offer do
  it "creation" do
    @offer = Offer.new :offered_url=>"https://picomoney.com/devcredits", :offered_amount => 10, :wanted_url => "https://oauth.jp", :wanted_amount =>5, :expires => 1.day.from_now
    @offer.should be_valid
    @offer.save!
    @offer.offer_token.should be

    @offer.should be_new

    @offer.start!
    @offer.should be_authorizing

    @offer.authorize!
    @offer.should be_open

    @offer.bid!
    @offer.should be_clearing

    @offer.clear!
    @offer.should be_closed

    @offer.should be_persisted
  end

end
