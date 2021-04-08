require 'station'

describe Station do

    it 'knows the station name' do
        expect(subject.name).to eq("Old Street")
    end

    it 'knows its zone' do                                                     
        expect(subject.zone).to eq(1)                                 
    end

end