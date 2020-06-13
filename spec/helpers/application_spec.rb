require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#format_date' do
    it 'returns a date in FULL DAY, FULL MONTH DAY NUMER, FULL YEAR format' do
      date_time = DateTime.new(2020, 6, 13, 1, 2, 3)

      expect(format_date(date_time)).to eq('Saturday, June 13, 2020')
    end
  end

  describe '#format_time' do
    it 'returns a time in HH:MM AM/PM format' do
      date_time = DateTime.new(2020, 6, 13, 1, 2, 3)

      expect(format_time(date_time)).to eq('01:02 AM')
    end
  end
end
