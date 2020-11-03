RSpec::Matchers.define :have_valid_key_policy do |policy_name|
  match do |key_type|
    key_type.has_valid_key_policy?(@iam_regex)
  end

  chain :with_iam_regex do |iam_regex|
    @iam_regex = iam_regex
  end
end
  