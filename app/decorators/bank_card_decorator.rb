class BankCardDecorator < MyDecorator
  LAST_NUMBERS_RANGE = (-4..).freeze
  def last_numbers
    number[LAST_NUMBERS_RANGE]
  end
end
