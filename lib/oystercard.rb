
class Oystercard
  attr_reader :oystercard, :balance, :entry_station, :exit_station, :journeys, :journey
MIN_CONSTANT = 1
MAX_CONSTANT = 90
  def initialize
    @balance = 0
    @journeys = []
    @journey = {}
  end

  def topup(money)
    if toomuch?(money)
     fail 'Maximum limit reached'
    else
     @balance += money
    end
  end

  def toomuch?(money)
    @balance + money > MAX_CONSTANT
  end


  def in_journey?
    if @entry_station == nil
      false
    else
      true
    end
  end

  def touch_in(location)
   fail 'Not enough money for journey!' if @balance < MIN_CONSTANT
   @entry_station = location
   @journey[:entry_station] = location
   @journeys << @journey
  end

  def touch_out(exit)
    deduct(MIN_CONSTANT)
      @entry_station = nil
      @exit_station = exit
      @journey[:exit_station] = exit
      @journeys << @journey
  end
end

  private
  def deduct(money)
    @balance = @balance - money
  end
