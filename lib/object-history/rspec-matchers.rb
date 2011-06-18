RSpec::Matchers.define :have_track do |accessor, expected|
  match do |actual|
    actual.__history.map{|x|x.send(accessor)} == expected
  end

  failure_message_for_should do |actual|
    "expected that #{actual.__history.map{|x|x.send(accessor)}} would be a precise multiple of #{expected}"
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual.__history.map{|x|x.send(accessor)}} would not be a precise multiple of #{expected}"
  end
end
