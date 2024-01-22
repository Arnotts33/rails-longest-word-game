require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def english_word
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included
    @answer.chars.all? { |letter| @letters.include?(letter)}
  end

  def score
    @letters = params[:letters]
    @answer = params[:answer]

    if !included
      @result = "Sorry but #{@answer.upcase} can't be built out of #{@letters}."
    elsif !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be a valid English word..."
    elsif included && ! english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be a valid English word..."
    else included && english_word
      @result = "Congratulations! #{@answer.upcase} is a valid English word"
    end
  end

end
