RSpec::Matchers.define :have_valid_vpc_endpoints do |vpc_id|
    print "inside matcher #{vpc_id}"
    match do |vpc|
      vpc.has_valid_vpc_endpoint?
    end

  end
  