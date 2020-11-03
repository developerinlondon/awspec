RSpec::Matchers.define :have_valid_key_policy do |policy_name|
    match do |key_type|
      key_type.has_valid_key_policy?
    end
  end
  