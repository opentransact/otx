require "spec_helper"

describe Asset do
  let(:attributes) do
    {
      :transaction_url       => 'https://picomoney.com/picopoints',
      :oauth_consumer_key    => 'abcdefg',
      :oauth_consumer_secret => '0123456'
    }
  end

  context 'when just created' do
    subject { Asset.create attributes }
    its(:verified?) { should be_false }
  end
end
