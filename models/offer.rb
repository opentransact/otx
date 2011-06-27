require 'state_machine'
require 'securerandom'

class Offer < ActiveRecord::Base

  validates_presence_of :offered_url, :wanted_url, :offered_amount, :wanted_amount

  state_machine :state, :initial=>:new do
    state :new, :authorizing, :open, :clearing, :closed, :cancelled

    after_transition any => :open do |a, transition|
      a.offered_at=Time.now
    end

    after_transition any => :cancelled do |a, transition|
      a.cancelled_at=Time.now
    end

    after_transition any => :closed do |a, transition|
      a.closed_at=Time.now
    end

    event :start do
      transition :new => :authorizing
    end

    event :authorize do
      transition :authorizing => :open
    end

    event :bid do
      transition :open => :clearing
    end

    event :clear do
      transition :clearing => :closed
    end

    event :cancel do
      transition [:new, :authorizing, :open] => :cancelled
    end

  end

  before_create :create_offer_token

  def create_offer_token
    self.offer_token = SecureRandom.hex
  end
end
