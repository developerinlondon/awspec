module Awspec::Helper
  module Finder
    module S3
      def find_bucket(id)
        res = s3_client.head_object({
                                      bucket: id,
                                      key: '/'
                                    })
        reutrn id if res.data.class == Aws::S3::Types::HeadObjectOutput
        rescue
          false
      end

      def find_kms_key(key_id)
        kms_client.describe_key(key_id: key_id).key_metadata.key_id
      # rescue
      #   nil
      end

      def get_kms_key_id(key_alias_name)
        #return nil unless defined?(key_alias_name)
        return key_alias_name unless key_alias_name.start_with?('alias/') rescue return nil
        found = nil
        next_marker = nil

        loop do
          res = kms_client.list_aliases(marker: next_marker, limit: 100)
          found = res.aliases.find { |key_alias| key_alias.alias_name == kwy_alias_name }
          (found.nil? && next_marker = res.next_marker) || break
        end

        find_kms_key(found.target_key_id) if found
      end

      def find_bucket_acl(id)
        s3_client.get_bucket_acl(bucket: id)
        rescue
          nil
      end

      def head_object(id, key)
        res = s3_client.head_object({
                                      bucket: id,
                                      key: key.sub(%r(\A/), '')
                                    })
        res.data.class == Aws::S3::Types::HeadObjectOutput
        rescue
          false
      end

      def get_object(id, key)
        res = s3_client.head_object({
                                      bucket: id,
                                      key: key
                                    })
        res.data.class == Aws::S3::Types::HeadObjectOutput
        rescue
          false
      end

      def put_object(id, key, body, server_side_encryption, ssekms_key_id)
        res = s3_client.put_object({
                                      bucket: id,
                                      key: key,
                                      server_side_encryption: server_side_encryption,
                                      ssekms_key_id: get_kms_key_id(ssekms_key_id),
                                      body: body
                                    })
        # rescue
        #   false
      end

      def put_prefix(id, key, server_side_encryption, ssekms_key_id)
        res = s3_client.put_object({
                                      bucket: id,
                                      key: key,
                                      server_side_encryption: server_side_encryption,
                                      ssekms_key_id: get_kms_key_id(ssekms_key_id)
                                    })
        # rescue
        #   false
      end

      def delete_object(id, key)
        res = s3_client.delete_object({
                                      bucket: id,
                                      key: key
                                    })
        rescue
          false
      end

      def list_bucket(id, prefix=nil)
        res = s3_client.list_objects_v2({
                                          bucket: id,
                                          prefix: prefix
                                        })
        res.data.class == Aws::S3::Types::ListObjectsV2Output
      rescue
        false
      end

      def find_bucket_cors(id)
        s3_client.get_bucket_cors(bucket: id)
      rescue
        nil
      end

      def find_bucket_policy(id)
        s3_client.get_bucket_policy(bucket: id)
      rescue
        nil
      end

      def find_bucket_logging(id)
        s3_client.get_bucket_logging(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_tag(id, tag_key)
        tag = nil
        begin
          bucket_tagging = s3_client.get_bucket_tagging(bucket: id)
          tag_set = bucket_tagging.tag_set
          tag = tag_set.find { |tag_obj| tag_obj.key == tag_key }
        rescue Aws::S3::Errors::ServiceError
          nil
        end
        return tag if tag
      end

      def find_bucket_versioning(id)
        s3_client.get_bucket_versioning(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_lifecycle_configuration(id)
        s3_client.get_bucket_lifecycle_configuration(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_server_side_encryption(id)
        res = s3_client.get_bucket_encryption(bucket: id)
        res.server_side_encryption_configuration
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def select_all_buckets
        s3_client.list_buckets.buckets
      end
    end
  end
end
