require 'Station'

describe Station do

  context 'confirm_class' do
    it {is_expected.to respond_to(:zone)}
    it {is_expected.to respond_to(:station)}
  end
end
