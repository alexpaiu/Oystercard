require 'oystercard'

describe Oystercard do

  let(:station) {double :station}
  let(:estation) {double :estation}
  before do |test|
    unless test.metadata[:no_top_up]
      subject.topup(3)
    end
    unless test.metadata[:no_touch_in]
     subject.touch_in(station)
   end
  end

  context 'card in/out,payments working?' do

      it'balance_0?',no_top_up: true,no_touch_in: true do
       oystercard = Oystercard.new
       expect(oystercard.balance).to eq(0)
      end
      it 'adds_money?' do
        oyster = Oystercard.new
        expect(oyster.topup(10)).to eq(10)
      end
      it 'raise_exemption?' do
        subject.topup(80)
        expect{ subject.topup(9000) }.to raise_error('Maximum limit reached')
      end
      it 'refuse_entry_if_no_min_balance?',no_touch_in: true, no_top_up: true do
       expect{ subject.touch_in(station) }.to raise_error('Not enough money for journey!')
      end
      it 'touch_in?' do
       expect(subject).to be_in_journey
      end
      it 'touch_out?' do
        subject.touch_out(estation)
        expect(subject).not_to be_in_journey
      end
  end

  context 'Journeys stores, deletes, confirms,charges working?' do

      it 'not_in_journey?', no_touch_in: true do
        expect(subject).not_to be_in_journey
      end
      it 'store_station?' do
        expect(subject.entry_station).to eq(station)
      end
      it 'in_journey? ' do
        expect(subject.in_journey?).to be(true)
      end
      it 'journey_false?' do
        subject.touch_out(estation)
        expect(subject.in_journey?).to be(false)
      end
      it 'deletes_location?' do
        subject.touch_out(estation)
        expect(subject.entry_station).to eq(nil)
      end
      it 'change_balance?' do
        expect { subject.touch_out(estation) }.to change { subject.balance }.by(-Oystercard::MIN_CONSTANT)
      end
      it 'save_entry_station?' do
        expect(subject.entry_station).to eq(station)
      end
      it 'save_exit_station?' do
        subject.touch_out(estation)
        expect(subject.exit_station).to eq(estation)
      end
      it '1st_journeys_list_empty?',no_touch_in: true do
        expect(subject.journeys).to be_empty
      end
      it 'both_entry_exit_saved_in_journey?' do
        subject.touch_out(estation)
        journey = { entry_station: station, exit_station: estation }
        expect(subject.journeys).to include(journey)
      end
   end

end
