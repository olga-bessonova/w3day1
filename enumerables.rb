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

    def my_zip(*arrays)
        length = self.length
        array_new = Array.new(length) {[]}

        self.each_with_index do |el, i|
            array_new[i] << self[i]
            arrays.each {|array| array_new[i] << array[i]}
        end
        return array_new

    end

    def my_rotate(num=1)
        new_array = Array.new(self.length)
        self.each_with_index {|ele, i| new_array[(i-num)%self.length]= ele}
        return new_array
    end


    
end

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# Example to check my_zip method

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]



# Example to check my_flatten method
# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

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