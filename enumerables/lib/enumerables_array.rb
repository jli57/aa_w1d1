class Array

  def my_each(&prc)
    for i in (0...self.length)
      prc.call(self[i])
    end
    self
  end

  def my_select(&prc)
    ret = []
    my_each {|el| ret << el if prc.call(el)}
    ret
  end

  def my_reject(&prc)
    ret = []
    my_each {|el| ret << el unless prc.call(el)}
    ret
  end

  def my_any?(&prc)
    ret = my_select {|el| prc.call(el)}
    !ret.empty?
  end

  def my_flatten
    ret = []
    my_each do |el|
      if el.is_a?(Array)
        ret += el.my_flatten
      else
        ret << el
      end
    end
    ret
  end

  def my_zip(*args)
    self.map.with_index do | el, ind |
      subarray = [el]
      args.each{ |array| subarray << array[ind] }
      subarray
    end
  end

  def my_rotate(int = 1)
    int = int % self.length
    self.drop(int) + self.take(int)
  end

  def my_join(separator = "")
    ret = ""
    my_each {|el| ret << el + separator }
    ret.delete_suffix(separator)
  end

  def my_reverse
    ret = []
    my_each { |el| ret.unshift(el) }
    ret
  end
  
  def bubble_sort!(&prc)
    prc = Proc.new{ |a,b| a <=> b } unless prc 
      
    sorted = false
    until sorted
      sorted = true 
      self[0...-1].each_with_index do | el, i |
        if prc.call(el, self[i+1]) == 1
          self[i+1], self[i] = self[i], self[i+1]
          sorted = false
        end 
      end
    end  
    
    self
  end 
  
  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end 
  
end

def substrings(string)
  ret = []
  i = 0
  while i < string.length
    k = 1   
    while i+k <= string.length 
      ret << string[i, k] unless ret.include?(string[i, k])
      k += 1
    end 
    i += 1
  end 
  ret
end

def subwords(word, dictionary)
  words = substrings(word)
  words.select {|w| dictionary.include?(w)}
end 

def factors(num)
  ret = []
  (1..num).each do |el|
    ret << el if num % el == 0
  end
  ret
end



