module Enumerable
    def my_each
        i = 0
        until self[i] == nil do
            yield(self[i])
            i += 1
        end
    end
    def my_each_with_index
        i = 0
        until self[i] == nil do
            yield(self[i], i)    
            i += 1
        end
    end
    def my_select
        i = 0
        array = []
        until self[i] == nil do
            array.push(self[i]) if yield(self[i])
            i += 1
        end
        array
    end
    def my_all?
        i = 0
        until self[i] == nil do
            return false if yield(self[i]) == false || yield(self[i]) == nil
            i += 1
        end
        true
    end
    def my_any?
        i = 0
        until self[i] == nil do
            return true unless yield(self[i]) == false || yield(self[i]) == nil
            i += 1
        end
        false
    end
    def my_none?
        i = 0
        until self[i] == nil do
            return false if yield(self[i]) == true
            i += 1
        end
        true
    end
    def my_count(item = '')
        counter = 0
        if block_given?
            self.my_each {|value| counter += 1 if yield(value)}
        else
            self.my_each {|value| counter += 1 if value == item}
        end
        counter
    end
    def my_map(&my_proc)
        array = []
        if my_proc == nil
            self.my_each {|value| array.push(yield(value))}
        else
            self.my_each {|value| array.push(my_proc.call(value))}
        end
        array
    end
    def my_inject
        memo = ''
        self.my_each_with_index do |value, index| 
            index == 0 ? memo = value : memo = yield(memo, value)
        end
        memo
    end
    def multiply_els
        self.inject(:*)
    end
end

#longer code just to practice lambdas
puts_item = ->(item) { puts item}
puts "\nmy_each vs. each\n"
numbers = [1, 2, 3, 4 ,5]
numbers.my_each {|item| puts_item.call(item)}
numbers.each {|item| puts_item.call(item)}

puts "\nmy_each_with_index vs. each_with_index\n"
numbers.my_each_with_index {|value, index| puts "value: #{value} index:#{index}"}
numbers.each_with_index {|value, index| puts "value: #{value} index:#{index}"}

puts "\nmy_select vs. select\n"
p numbers.my_select {|value| value.even?}
p numbers.select {|value| value.even?}

puts "\nmy_all? vs. all?\n"
p numbers.my_all? {|value| value.even?}
p numbers.all? {|value| value.even?}

puts "\nmy_any? vs. any?\n"
p numbers.my_any? {|value| value.even?}
p numbers.any? {|value| value.even?}

puts "\nmy_none? vs. none?\n"
p numbers.my_none? {|value| value.even?}
p numbers.none? {|value| value.even?}

puts "\nmy_count vs. count\n"
p numbers.my_count {|number| number.even?}
p numbers.count {|number| number.even?}
p numbers.count(1)
p numbers.count(1)

puts "\nmy_map vs. map\n"
a_proc = Proc.new { |number| number*number*number }
p numbers.my_map {|number| number*number}
p numbers.my_map(&a_proc)
p numbers.map {|number| number*number}
p numbers.map(&a_proc)
#lets see what happens if both a proc and a block are given, an error raises.
#failed attempt to handle that error:
#begin
#    p numbers.my_map(&a_proc) {|number| number*number}
#rescue StandardError
#    p numbers.my_map(&a_proc)
#end
puts "\nmy_inject vs. inject\n"
p numbers.my_inject {|memo, value| memo * value}
p numbers.multiply_els
