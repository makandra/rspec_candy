RSpecCandy::Switcher.define_matcher :be_same_second_as do |expected|

  match do |actual|
    actual.to_i == expected.to_i
  end


end

