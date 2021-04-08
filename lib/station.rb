require_relative 'oystercard'

class Station
attr_reader :name, :zone

NAME = "Old Street"
ZONE = 1

    def initialize
        @name = NAME
        @zone = ZONE
    end

    # def name
    #     @name
    # end

    # def zone
    #     @zone
    # end

end