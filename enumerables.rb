class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        arr = []
        self.my_each {|el| arr << el if prc.call(el)}
        return arr
    end

    def my_reject(&prc)
        arr = []
        self.my_each {|el| arr << el if !prc.call(el)}
        return arr
    end
    def my_any?(&prc)
        new_array = self.my_select{|ele| prc.call(ele)}
        new_array.length > 0
    end

    def my_all?(&prc)
        new_array = self.my_select{|ele| prc.call(ele)}
        new_array.length == self.length
    end

    def add(a,b)
        a+b
    end
    def my_flatten
        return self if self.none? {|ele| ele.instance_of? Array}
        array = []
        self.each do |ele|
            if !ele.instance_of? Array
                array << ele
            else
                array.concat(ele.my_flatten)
            end
        end
        return array
    end

    
end

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# Example to check my_each method
# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#     puts num
#    end.my_each do |num|
#     puts num
#    end
#    # => 1
#     #    2
#     #    3
#     #    1
#     #    2
#     #    3
   
#    p return_value  # => [1, 2, 3]


# Example to check my_select method
# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []


# Example to check my_reject method
# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# Example to check my_any? method
# a = [1, 2, 3]
# # p a.my_any? { |num| num > 1 } # => true
# # p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true