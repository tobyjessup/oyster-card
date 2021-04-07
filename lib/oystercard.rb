class Oystercard
  attr_reader :balance, :max_balance, :min_balance, :in_journey, :entry_station, :journeys

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE )
    @balance = balance
    @max_balance = MAX_BALANCE
    @min_balance = MIN_BALANCE
    @entry_station = nil
    @journeys = []
  end

  def top_up(sum)
    fail "max balance of #{max_balance} exceeded" if balance_exceeded?(sum)

    @balance += sum
  end
  
  def in_journey?
    entry_station != nil
  end

  def touch_in(station)
    fail 'Not enough funds!' unless minimum_balance?
    @entry_station = station
  end

  def touch_out(exit_station)
    deduct(min_balance)
    @journeys << create_journey(@entry_station, exit_station)
    @entry_station = nil
  end

  private

  def balance_exceeded?(sum)
    @balance+sum > @max_balance
  end

  def minimum_balance?
    @balance >= @min_balance
  end

  def deduct(sum)
    @balance -= sum
  end

  def create_journey(entry_station, exit_station)
    {
      entry_station: entry_station,
      exit_station: exit_station      
    }
  end
end