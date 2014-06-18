def stock_picker(*stocks)
  max_value = 0
  max_indexes = []
  iter = 0
  while buy = stocks.shift
    iter += 1
    stocks.each do |sell|
      if buy-sell > max_value
        max_value = buy-sell
        max_indexes = iter, stocks.index(sell) + iter + 1
      end
    end
  end
  max_indexes
end

string = ARGV || "Enter integers seperated by commas!"

string.map! {|a| a.to_i}
print stock_picker(*string)