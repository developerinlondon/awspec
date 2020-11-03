RSpec::Matchers.define :have_valid_key_policy do |policy_name|
  match do |key_type|
    key_type.has_valid_key_policy?(@iam_prefix)
  end

  chain :with_iam_prefix do |iam_prefix|
    @iam_prefix = iam_prefix
  end
end
  