# RSpec::Matchers.define :with_prefix do |prefix|
#   match do |s3_bucket|
#     s3_bucket.has_get_objects_permission?(prefix)
#   end
# end
