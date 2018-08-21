require_relative  'game'
def valid_play_test(string)
  game = GhostGame.new([])
  game.valid_play?(string)

end

def test_game
  dictionary = GhostGame.parse_dictionary("dictionary.txt")
  game = GhostGame.new([Player.new("Austin"), AiPlayer.new(dictionary), Player.new("Jingna"), AiPlayer.new(dictionary)], dictionary)
  game.run
end

test_game
