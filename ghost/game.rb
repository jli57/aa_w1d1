class GhostGame

  GHOST = "GHOST"
  def initialize(players, dictionary)
    @fragment = ""
    @players = players
    @dictionary = dictionary
    @losses = Hash.new(0)
    @players.each { |player| @losses[player] = 0 }
  end

  def self.parse_dictionary(file_name)
    dictionary = {}
    File.foreach(file_name) do |line|
      dictionary[line.chomp] = true
    end
    dictionary
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[-1]
  end

  def next_player
    @players.rotate!
  end

  def take_turn(player)
    puts "Fragment so far: #{@fragment}"
    curr_guess = player.guess(@players.length, @fragment)
    until valid_play?(curr_guess)
      player.alert_invalid_guess
      curr_guess = current_player.guess
    end
    @fragment += curr_guess
  end

  def play_round(i)
    puts "Round #{i} Begins!"
    until lose?
      take_turn(current_player)
      next_player
    end
    puts "#{previous_player.name} is the Loser!"
    puts "The Losing Word was #{@fragment}"
    record(previous_player)
    display_standings
    remove_player
    @fragment = ""
    reset_players
  end

  def reset_players
    @players.each { |player| player.reset(@dictionary) }
  end

  def run
    i = 1
    until @players.length == 1
      play_round(i)
      i += 1
    end
    puts "#{@players[0].name} is the Winner!"
  end

  def remove_player
    @players.reject!{ |player| @losses[player] == 5 }
  end

  def display_standings
    @losses.each do |player, losses|
      puts "#{player.name}: #{GHOST[0, losses]}"
    end
  end

  def record(player)
    @losses[player]+= 1
  end

  def lose?
    return @dictionary[@fragment]
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
  attr_reader :name
  def initialize(name = "Bob")
    @name = name
  end

  def guess(player_number=nil, fragment=nil)
    print "Enter your guess #{@name}: "
    gets.chomp
  end

  def alert_invalid_guess
    print "Invalid guess, please guess again. "
  end

  def reset(dictionary)

  end

end

class AiPlayer
  attr_reader :name
  def initialize(dictionary)
    @name = 'Skynet'
    @current_possible_words = dictionary.dup
  end

  def update_current_words(fragment)
    @current_possible_words.select! do |word, v|
      word.index(fragment) == 0 && word.length > fragment.length
    end
  end

  def guess(player_number, fragment)
    update_current_words(fragment)
    @current_possible_words.each do |word, value|
      desired_length = word.length - fragment.length
      if  desired_length <= player_number && word.length != fragment.length + 1
        return word[fragment.length]
      end
    end
    guess = @current_possible_words.keys.sample[fragment.length]
    puts "#{@name} guessed #{guess}"
    guess
  end

  def reset(dictionary)
    @current_possible_words = dictionary.dup
  end
end
