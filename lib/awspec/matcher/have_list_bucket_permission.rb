RSpec::Matchers.define :have_list_bucket_permission do
  match do |s3_bucket|
    s3_bucket.has_list_bucket_permission?(@prefix)
  end

  chain :with_prefix do |prefix|
    @prefix = prefix
  end

end
