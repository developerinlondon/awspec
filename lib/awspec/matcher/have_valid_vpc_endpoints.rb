RSpec::Matchers.define :have_valid_vpc_endpoints do |vpc_id|
    match do |vpc|
      vpc.has_valid_vpc_endpoints?(@specified_services)
    end

    chain :with_only_specified_services do |specified_services|
      @specified_services = specified_services
    end
  
  end
  