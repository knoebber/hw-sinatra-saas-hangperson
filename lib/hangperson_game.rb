class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    @word.size.times{@word_with_guesses << "-"}
  end
  
  def guess(g)
    raise ArgumentError if g==nil || g == '' || (g =~ /^[[:alpha:]]$/) == nil
    if @word.include? g.downcase
      if @guesses.include? g.downcase
        return false
      else
        @guesses << g 
        (0...@word.size).each{ |i| @word_with_guesses[i] = @word[i] if @word[i] == g }
        return true
      end
    else
      if @wrong_guesses.include? g.downcase
        return false 
      else
        @wrong_guesses << g
        return true
      end
    end
  end  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
 def check_win_or_lose
    if not word_with_guesses.include? '-'
      return :win
    elsif wrong_guesses.size >= 7
      return :lose
    else
      return :play
    end
  end
end
