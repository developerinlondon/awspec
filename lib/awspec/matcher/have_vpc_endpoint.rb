RSpec::Matchers.define :have_vpc_endpoint do |vpc_id|
    match do |vpc|
      vpc.has_vpc_endpoint?(vpc_id)
    end
  
    # chain :as_accepter do
    #   @accepter_or_requester = 'accepter'
    # end
  
    # chain :as_requester do
    #   @accepter_or_requester = 'requester'
    # end
  end
  