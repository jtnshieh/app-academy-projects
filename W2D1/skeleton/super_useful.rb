# PHASE 2
def convert_to_int(str)
  begin
    num = Integer(str)
  rescue ArgumentError
    puts "Cannot convert to Integer. Please ensure you pass a valid numeric string."
  ensure
    num ||= nil
  end

  num
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class CoffeeError < StandardError
  def message
    "I can't have any more caffeine. My poor heart couldn't take it. You can try again."
  end
end

class NotAFruitError < StandardError
  def message
    "That doesn't look like a fruit. You tricked me. * runs away *"
  end
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise NotAFruitError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError => e
    puts e.message
    retry
  rescue NotAFruitError => e
    puts e.message
  end
end

# PHASE 4
class YearsKnownError < StandardError
  def message
    "Best friends have to know each other for 5 or more years."
  end
end

class BlankResponseError < StandardError
  def message
    "You must include name and/or favorite pastime."
  end
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    begin
      @name = name
      @yrs_known = yrs_known
      raise YearsKnownError if @yrs_known < 5
      @fav_pastime = fav_pastime
      raise BlankResponseError if @name.length == 0 || @fav_pastime.length == 0
    rescue YearsKnownError => e
      puts e.message
    rescue BlankResponseError => e
      puts e.message
    ensure
      @yrs_known ||= nil
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
