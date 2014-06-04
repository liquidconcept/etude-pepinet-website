module LatinToInteger
  def latin_to_integer(latin_number)
    latin_number = latin_number.upcase.split(//).reverse
    @converter ||= Converter.new
    @converter.verify(latin_number)
    @converter.calculate(latin_number)
  end
end

class Converter
  LETTERARRAY = ["I", "V", "X", "L", "C", "D", "M"]
  VALUEARRAY = [1, 5, 10, 50, 100, 500, 1000]

  def verify(latin_number)
    same_letter_counter = 0

    latin_number.each_with_index do |current_latin_number, i|
      group_current_letter = (group_of(current_latin_number))
      group_next_letter = (group_of(latin_number[i-1]))

      if i > 0
        #count same letter
        if LETTERARRAY.index(current_latin_number) == LETTERARRAY.index(latin_number[i-1])
          same_letter_counter += 1
        elsif LETTERARRAY.index(current_latin_number) != LETTERARRAY.index(latin_number[i-1])
          same_letter_counter = 0
        end

        #verify if the letter can be this amount of time
        if too_many_times_group_x(group_current_letter, same_letter_counter, current_latin_number) ||
           too_many_times_group_v(group_current_letter, same_letter_counter) ||
           too_many_times_letter_m(current_latin_number, same_letter_counter)
          raise "there's more than #{same_letter_counter} times the letter #{current_latin_number} !"
        end

        #verify if letters are compatible
        if is_next_letter_incompatible_for_group_x(group_current_letter, current_latin_number, latin_number, i) ||
           is_next_letter_incompatible_for_group_v(group_current_letter, current_latin_number, latin_number, i) ||
           is_two_letter_of_group_v(group_current_letter, group_next_letter)
          raise "#{current_latin_number} is a letter incompatible with #{latin_number[i-1]}"
        end

        #verify if there's less than two times a letter smaller than the next letter
        if i > 1 && same_letter_counter > 0 && LETTERARRAY.index(latin_number[i-2]) > LETTERARRAY.index(current_latin_number)
          raise "you can only put one time a letter smaller than the next letter"
        end
      end
    end
  end

  def calculate(latin_number)
    integer_number = 0

    latin_number.each_with_index do |current_latin_number, i|
      if i > 0 && LETTERARRAY.index(current_latin_number) < LETTERARRAY.index(latin_number[i-1])
       integer_number -= VALUEARRAY[LETTERARRAY.index(current_latin_number)]
      else
       integer_number += VALUEARRAY[LETTERARRAY.index(current_latin_number)]
      end
    end

    return integer_number
  end

  def group_of(letter)
    if (LETTERARRAY.index(letter)+2)%2 == 0
      return :X
    elsif (LETTERARRAY.index(letter)+2)%2 == 1
      return :V
    end
  end

  def too_many_times_group_x(group_current_letter, same_letter_counter, current_latin_number)
    ### this method has for goal to verify that CCCC is impossible ####
    # 1 the letter is of group x
    # 2 the letter is more than three time
    # 3 the letter is not "M"
    if (group_current_letter == :X && same_letter_counter > 2 && current_latin_number != LETTERARRAY.last)
      return true
    end
  end

  def too_many_times_group_v(group_current_letter, same_letter_counter)
    ### this method has for goal to verify that VV is impossible ####
    # 1 the letter is of group v
    # 2 the letter is more than one time
    if (group_current_letter == :V && same_letter_counter > 0)
      return true
    end
  end

  def too_many_times_letter_m(current_latin_number, same_letter_counter)
    ### this method has for goal to verify that MMMMM is impossible ####
    # 1 the letter is "M"
    # 2 the letter is more than 4 times

    if (current_latin_number == LETTERARRAY.last && same_letter_counter > 3)
      return true
    end
  end

  def is_next_letter_incompatible_for_group_v(group_current_letter, current_latin_number, latin_number, i)
    ### this method has for goal to verify that VX is impossible ####
    # 1 the letter is of group v
    # 2 the index of the current letter is smaller than the index of the next letter
    if (group_current_letter == :V && LETTERARRAY.index(current_latin_number) < LETTERARRAY.index(latin_number[i-1]))
      return true
    end
  end

  def is_next_letter_incompatible_for_group_x(group_current_letter, current_latin_number, latin_number, i)
    ### this method has for goal to verify that IC is impossible ####
    # 1 the letter is of group x
    # 2 the difference between the previous letter index and the current letter index is more than two
    if (group_current_letter == :X && (LETTERARRAY.index(latin_number[i-1])-LETTERARRAY.index(current_latin_number) >= 3))
      return true
    end
  end

  def is_two_letter_of_group_v(group_current_letter, group_next_letter)
    ### this method has for goal to verify that LV is impossible ####
    # 1 the letter is of group V
    # 2 the next letter is of group V
    if (group_current_letter == :V && group_next_letter == :V)
      return true
    end
  end
end