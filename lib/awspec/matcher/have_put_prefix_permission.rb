RSpec::Matchers.define :have_put_prefix_permission do
    match do |s3_bucket|
      s3_bucket.has_put_prefix_permission?(s3_prefix: @prefix, server_side_encryption: @server_side_encryption, ssekms_key_id: @ssekms_key_id)
    end

    chain :with_prefix do |prefix|
        @prefix = prefix
    end

    chain :using_kms_key_id do |kms_key_id|
      @server_side_encryption = "aws:kms"
      @ssekms_key_id = kms_key_id
    end

end