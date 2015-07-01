require 'active_support/all'

require './library_manager.rb'
require './author.rb'
require './book.rb'
require './published_book.rb'
require './reader.rb'
require './reader_with_book.rb'

class LibraryManager

  attr_accessor :reader_with_book, :issue_datetime

  def initialize reader_with_book, issue_datetime
    @reader_with_book = reader_with_book
    @issue_datetime = issue_datetime
  end

  def penalty
    expired_hours = ((Time.now.utc.to_i - issue_datetime.to_time.to_i) / 3600.0).ceil
    penalty_in_cents = reader_with_book.penalty  expired_hours
    if penalty_in_cents < 0 || reader_with_book.book_price < 0 
      0 
    else
      penalty_in_cents
    end 
  end

  def could_meet_each_other? first_author, second_author
    first_author.can_meet? second_author
  end

  def days_to_buy
    (1.0 / (24.0 * reader_with_book.book_penalty_per_hour / reader_with_book.book_price)).ceil
  end

  def transliterate author
    transliteration_rules = {
      А: "A", а: "a",
      Б: "B", б: "b",
      В: "V", в: "v",
      Г: "H", г: "h",
      Ґ: "G", ґ: "g",
      Д: "D", д: "d",
      Е: "E", е: "e",
              є: "ie",
      Ж: "Zh", ж: "zh",
      З: "Z", з: "z",
      И: "Y", и: "y",
      І: "I", і: "i",
              ї: "i",
              й: "i",
      К: "K", к: "k",
      Л: "L", л: "l",
      М: "M", м: "m",
      Н: "N", н: "n",
      О: "O", о: "o",
      П: "P", п: "p",
      Р: "R", р: "r",
      С: "S", с: "s",
      Т: "T", т: "t",
      У: "U", у: "u",
      Ф: "F", ф: "f",
      Х: "Kh", х: "kh",
      Ц: "Ts", ц: "ts",
      Ч: "Ch", ч: "ch",
      Ш: "Sh", ш: "sh",
      Щ: "Shch", щ: "shch",
               ю: "iu",
               я: "ia",
      ь: "", ’: ""     
    }
    first_letters = {
      Є: "Ye", є: "ye",
      Ї: "Yi", ї: "yi",
      Й: "Y", й: "y",
      Ю: "Yu", ю: "yu",
      Я: "Ya", я: "ya",
    }
    ukr_name = author.name
    letters = ukr_name.split('')
    replaced_letters = letters.map.with_index do |x,i|
      if ((first_letters.has_key? x.to_sym) && ((i==0) || letters[i-1]==' ')) then
        first_letters[x.to_sym]
      elsif transliteration_rules.has_key? x.to_sym then
        transliteration_rules[x.to_sym]
      else
        x
      end
    end
    replaced_letters.join('')

  end

  def penalty_to_finish
    time_to_finish = reader_with_book.time_to_finish
    expired_hours = ((Time.now.utc.to_i - issue_datetime.to_time.to_i) / 3600.0 + time_to_finish).ceil
    penalty_in_cents = reader_with_book.penalty expired_hours
    
    if penalty_in_cents < 0 || reader_with_book.book_price < 0 
      0 
    else
      penalty_in_cents
    end   
  end

  def email_notification_params
    {
      
    }
  end

  def email_notification
    #use email_notofication_params
  end


end
