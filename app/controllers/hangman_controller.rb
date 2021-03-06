class HangmanController < ApplicationController
  def index
    resetGameState
  end
  
  def game
    @guesses = cookies[:guesses].to_i
    @word = cookies[:word]
    @lettersUsed = cookies[:lettersUsed]
  end
  
  def letter
    updateCookiesWithLetterInput(params[:letter])
    @guesses = cookies[:guesses].to_i
    @lettersUsed = cookies[:lettersUsed]
    @word = cookies[:word]
    @endgameFlag = isEndgameMet(@word, @lettersUsed)
    @report = false
    if (@endgameFlag)
      updateWordScore(@guesses >= getMaxGuesses() ? "loss" : "win", cookies[:recordId].to_i)
    end
    render :game
  end
  
  def newgame
    resetGameState
    @guesses = cookies[:guesses].to_i
    @lettersUsed = cookies[:lettersUsed]
    @word = cookies[:word]
    @endgameFlag = isEndgameMet(@word, @lettersUsed)
    @report = false
    render :game
  end

  def report
    receiveReport(params[:report])
    @guesses = cookies[:guesses].to_i
    @lettersUsed = cookies[:lettersUsed]
    @word = cookies[:word]
    @endgameFlag = isEndgameMet(@word, @lettersUsed)
    @report = true
    render :game
  end

private
  def resetGameState
    cookies[:guesses] = 0
    cookies[:lettersUsed] = ""
    record = Record.order(Arel.sql('RANDOM()')).first
    cookies[:word] = record.word
    cookies[:recordId] = record.id 
  end

private
  def receiveReport(report)
    record = Record.find_by(word: report)
    unless (record.revised)
    	record.revision = true
    	record.save
    end
  end

private
  def isEndgameMet (word, lettersUsed)
    wordChecker = word.clone
    lettersUsed.each_char { |c|
      wordChecker.delete! c
    }
    if wordChecker.length > 0
      return false
    end
    return true
  end

private
  def updateWordScore(result, id)
   record = Record.find(id)
   if (result == "win")
     record.victories += 1
   else
     record.defeats += 1
   end
   record.save
 end
     
private 
  def updateCookiesWithLetterInput(letter)
    fullCharList = letter + addSpecialChars(letter)
    cookies[:guesses] = cookies[:guesses].to_i + addOneIfIncorrectGuess(fullCharList, cookies[:word])
    if (cookies[:guesses].to_i >= getMaxGuesses())
      cookies[:lettersUsed] = getAllValidLetters()
    else
      cookies[:lettersUsed] += fullCharList
    end
  end

private
  def addOneIfIncorrectGuess (charList, word)
     charList.each_char { |c|
       if (word.include? c)
         return 0
       end
       }
     return 1
  end
 
private 
  def addSpecialChars (char=" ")
    case char
    when 'a'
      "??????"
    when 'e'
      "????"
    when 'i'
      "??"
    when 'o'
      "??????"
    when 'u'
      "??"
    when 'c'
      "??"
    when " "
      "??????????????????????"
    else
      ""
    end
  end
  
private
  def getAllValidLetters
    specialChars = addSpecialChars()
    completeCharList = ('a'..'z').to_a.join(',')
    completeCharList + specialChars
  end

private
  def getMaxGuesses
    5
  end
end
