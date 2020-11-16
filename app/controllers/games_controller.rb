
require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = params[:letter]
    @letters =  Array.new(10) { ("a".."z").to_a.sample }
  end

  def score
    @score = 0
    @answer = params[:answer]
    if !english_word?(@answer)
      @message = "sorry but #{@answer} does not seem to be a valid English word..."
    elsif included?(@answer, @letters.to_s)
      @message = "sorry but #{@answer} does not in the grid..."
    else
      @message = "congratulations!"
    end
  end

  def english_word?(answer)
    reponse = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(reponse.read)
    return json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
