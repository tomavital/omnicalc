class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    text_split_into_array = @text.split

    @word_count = text_split_into_array.length

    @character_count_with_spaces = @text.chomp.length

    @character_count_without_spaces = @text.gsub(" ","").length

    text_split_no_punctuation = @text.gsub(",","").gsub(".","").split
    w_count = 0
    text_split_no_punctuation.each do |word|
      if word.downcase == @special_word.downcase
        w_count = w_count + 1
      end
    end
    @occurrences = w_count
    #  text_split_into_array.count("@special_word")
    # 1. split into an array of words


    # 2. compare each member of the array to the special words
    # 3. if == speaical word, @occurences +=1
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    r= (@apr/12)/100
    pr= @principal
    n= @years*12
    a=(1+r)**n
    b=pr*r
    c=b*a/a-1

    @monthly_payment = c

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @starting-@ending
    @minutes = (@starting-@ending)/60
    @hours = (@starting-@ending)/3600
    @days = (@starting-@ending)/86400
    @weeks = (@starting-@ending)/604800
    @years = (@starting-@ending)/31536000

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    last = @numbers.length-1
    @range = @sorted_numbers[last] - @sorted_numbers[0]

    a_order = @numbers.sort
    length1 = (@numbers.length - 1) / 2
    if @numbers.length%2 == 1
      median = a_order[length1]
    else
      length2 = length1 + 1
      median = (a_order[length1] + a_order[length2]) / 2
    end
    @median = median

    @sum = @numbers.sum

    @mean = @sum/@numbers.length
  squared_numbers = []
  @numbers.each do |num|
     square = (num - @mean) * (num - @mean)
     squared_numbers.push(square)
   end
sum = squared_numbers.sum
    @variance = sum/@numbers.length
    # actually a mistake in the target, should be -1

    @standard_deviation = @variance **0.5
    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
