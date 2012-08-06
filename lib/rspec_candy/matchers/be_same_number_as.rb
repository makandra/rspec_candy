RSpecCandy::Switcher.define_matcher :be_same_number_as do |expected|

  match do |actual|
    actual.is_a?(Numeric) && expected.is_a?(Numeric) && normalize(expected) == normalize(actual)
  end

  def normalize(number)
    number.to_s.tap do |str|
      str << ".0" unless str.include?('.')
    end
  end

end

