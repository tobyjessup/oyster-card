require 'oystercard'

describe Oystercard do

  let (:default_balance) { Oystercard::DEFAULT_BALANCE }
  let (:max_balance) { Oystercard::MAX_BALANCE }
  let (:min_balance) { Oystercard::MIN_BALANCE }
  let (:topped_up_card) { Oystercard.new(min_balance) }
  let (:station) { double("station") }

  describe '#balance' do
    it 'responds' do
      expect(subject).to respond_to(:balance)
    end

    it 'returns default balance' do
      expect(subject.balance).to eq(default_balance)
    end
  end

  describe '#top_up' do
    it 'responds' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'top up increases balance' do
      sum = 10
      subject.top_up(sum)
      expect(subject.balance).to eq(default_balance + sum)
    end

    it 'raises error if exceeds max balance' do
      sum = max_balance + 1
      expect { subject.top_up(sum) }.to raise_error("max balance of #{max_balance} exceeded")
    end
  end

  # describe '#deduct' do
  #   it { expect(subject).to respond_to(:deduct).with(1).argument }

  #   it 'reduces balance' do
  #     sum = 30
  #     expect(subject.deduct(sum)).to eq(default_balance - sum)
  #   end
  # end

  describe '#in_journey?' do 
    it { expect(subject).to respond_to(:in_journey?) }
    it { expect(subject).not_to be_in_journey }
  end
  
  describe '#touch_in' do
    it { expect(topped_up_card).to respond_to(:touch_in).with(1).argument }
    
    it 'changes in_journey to true' do
      topped_up_card.touch_in(station)
      expect(topped_up_card).to be_in_journey
    end

    it 'raises error is minimum balance is too low' do
      zero_balance_card = Oystercard.new(0)
      expect { zero_balance_card.touch_in(station) }.to raise_error('Not enough funds!')
    end
  end

  describe '#touch_out' do
    it { expect(subject).to respond_to(:touch_out) }
    it 'changes in_journey back to false' do
      topped_up_card.touch_in(station)
      topped_up_card.touch_out
      expect(topped_up_card).not_to be_in_journey
    end
    it 'deducts fair when touch_out' do
      topped_up_card.touch_in(station)
      expect{ topped_up_card.touch_out }.to change{ topped_up_card.balance }.by(-min_balance)
    end
  end

  describe '#entry_station' do
    it { expect(subject.entry_station).to be_nil }
    it 'accepts station' do
      topped_up_card.touch_in(station)
      expect(topped_up_card.entry_station).to eq(station)
    end

    it 'resets @entry_station' do
      topped_up_card.touch_in(station)
      topped_up_card.touch_out
      expect(topped_up_card.entry_station).to be_nil
    end
  end
end