require 'journey'

describe Journey do
  context 'confirm_class' do
    it {is_expected.to respond_to(:finish)}
    it {is_expected.to respond_to(:complete?)}
    it {is_expected.to respond_to(:fare)}
  end
end
