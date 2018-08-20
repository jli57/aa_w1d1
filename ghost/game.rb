class GhostGame

  def initialize(players)
    @fragment = ""
    @players = players
    @dictionary = {'apple' => 1, 'aardvark' => 1, 'bats' => 1, 'zoo' => 1}
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[1]
  end

  def next_player
    @players.reverse!
  end

  def take_turn

    curr_guess = current_player.guess
    until valid_play?(curr_guess)

    end
  end

  def valid_play?(string)
    temp_fragment = @fragment + string
    return false unless ('a'..'z').to_a.include?(string)
    @dictionary.keys.each do |word|
      return true if word.index(temp_fragment) == 0
    end
    false
  end

end

class Player
  def initialize(name="Bob")
    @name = name
  end

  def guess
    print "Enter your guess: "
    gets.chomp
  end

  def alert_invalid_guess(guess)
    print "Invalid guess, please guess again."
  end

end
