RSpec::Matchers.define :have_vpc_endpoint do |vpc_id|
    print vpc_id
    match do |vpc_id|
      vpc.has_vpc_endpoint?
    end
  
    # chain :as_accepter do
    #   @accepter_or_requester = 'accepter'
    # end
  
    # chain :as_requester do
    #   @accepter_or_requester = 'requester'
    # end
  end
  