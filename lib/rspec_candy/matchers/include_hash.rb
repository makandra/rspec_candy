RSpecCandy::Switcher.define_matcher :include_hash do |expected|

  match do |actual|
    !actual.nil? && expected.values == actual.values_at(*expected.keys)
  end

end
