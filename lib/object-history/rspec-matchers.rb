RSpec::Matchers.define :have_track do |accessor, expected|
  match do |actual|
    if actual.__history
      actual.__history.map{|x|x.send(accessor)} == expected
    else
      [] == expected
    end
  end

  failure_message_for_should do |actual|
    if actual.__history
      "expected that #{actual.__history.map{|x|x.send(accessor)}} would be a precise multiple of #{expected}"
    else
      "expected that #{[]} would be a precise multiple of #{expected}"
    end
  end

  failure_message_for_should_not do |actual|
    if actual.__history
      "expected that #{actual.__history.map{|x|x.send(accessor)}} would not be a precise multiple of #{expected}"
    else
      "expected that #{[]} would not be a precise multiple of #{expected}"
    end
  end
end
