i = 0
numbers = []

def call_while(i, numbers, num, inc)
	while i < num
		puts "At the top i is #{i}"
		numbers.push(i)
	
		i += inc
		puts "Numbers now: ", numbers
		puts "At the bottom i is #{i}"
	end
end

call_while(i, numbers, 6, 1)

puts "The numbers: "

# remember you can write this 2 other ways?
numbers.each {|num| puts num}

(0..6).each do |i|
	puts i
end
