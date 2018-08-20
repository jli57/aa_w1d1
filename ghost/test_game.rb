require_relative  'game'
def valid_play_test(string)
  game = GhostGame.new([])
  game.valid_play?(string)

end

puts valid_play_test("l") #true
puts valid_play_test("apple") #false
puts valid_play_test("a") #false
