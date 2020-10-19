RSpec::Matchers.define :have_put_object_permission do
    match do |s3_bucket|
      s3_bucket.has_put_object_permission?(s3_file: @remote_file, local_file: @local_file, server_side_encryption: @server_side_encryption, ssekms_key_id: @ssekms_key_id)
    end

    chain :with_local_file do |local_file|
        @local_file = local_file
    end

    chain :with_remote_file do |remote_file|
      @remote_file = remote_file
    end    

    chain :using_kms_key_id do |kms_key_id|
      @server_side_encryption = "aws:kms"
      @ssekms_key_id = kms_key_id
    end

end