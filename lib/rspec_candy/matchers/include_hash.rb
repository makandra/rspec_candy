RSpecCandy::Switcher.define_matcher :include_hash do |expected|

  match do |actual|
    !actual.nil? && actual.slice(*expected.keys) == expected
  end

end
