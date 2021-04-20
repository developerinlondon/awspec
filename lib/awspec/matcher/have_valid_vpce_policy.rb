RSpec::Matchers.define :have_valid_vpce_policy do
    match do |vpce|
      vpce.has_valid_vpce_policy?(@iam_regex)
    end
  
    chain :with_iam_regex do |iam_regex|
      @iam_regex = iam_regex
    end
  end
