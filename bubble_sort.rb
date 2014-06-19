arr = [1, 57, 3, 8, 9, 3, 2,77, 6, 54, 15, 5, 43, 3, 2]

print arr
puts
puts

def bubble_sort(arr)

	for i in (0...arr.length) do 
		for j in ((i+1)...arr.length) do
			if arr[i] > arr[j]
				arr[i], arr[j] = arr[j], arr[i]
				swapped = true
			end
		end
	end	


	arr
end

def bubble_sort_by(arr)
	swapped = true
	while swapped
		swapped = false
		arr.each_index do |i|
			
			if i != arr.length-1 && yield(arr[i],arr[i+1]) > 0
				arr[i], arr[i + 1] = arr[i + 1], arr[i]
				swapped = true
			end
			
		end
		p arr
	end

	arr
end

bubble_sort_by(arr) { |x, y| x%y - y % x }
print arr