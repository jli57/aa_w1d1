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

end
