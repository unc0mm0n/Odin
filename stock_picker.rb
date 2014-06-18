def stock_picker(*stocks)
  max_value = -1 / 0.0000000000000001
  max_indexes = []
  iter = 0
  while buy = stocks.shift
    iter += 1
    stocks.each do |sell|
      if sell-buy > max_value
        max_value = sell-buy
        max_indexes = iter, stocks.index(sell) + iter + 1
      end
    end
  end
  max_indexes
end

# Too lazy to check valid input
string = ARGV

string.map! {|a| a.to_i}
print stock_picker(*string)