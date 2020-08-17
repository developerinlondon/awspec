module Awspec::Helper
  module Finder
    module S3
      def find_bucket(id)
        # s3_client.list_buckets[:buckets].find do |bucket|
        #   bucket.name == id
        # end
        res = s3_client.head_object({
                                      bucket: id,
                                      key: '/'
                                    })
        reutrn id if res.data.class == Aws::S3::Types::HeadObjectOutput
        rescue Aws::S3::Errors::NotFound => e
         if s3_client.debug_mode
            puts 'AWSPEC: Bucket Not Found'
          else
            return false
          end
        # rescue Aws::S3::Errors::ServiceError => e
        #   if s3_client.debug_mode
        #     throw e
        #   else
        #     return false
        #   end
      end

      def find_bucket_acl(id)
        s3_client.get_bucket_acl(bucket: id)
        rescue Aws::S3::Errors::ServiceError => e
          if s3_client.debug_mode
            throw e
          else
            return nil
          end
      end

      def head_object(id, key)
        res = s3_client.head_object({
                                      bucket: id,
                                      key: key.sub(%r(\A/), '')
                                    })
        res.data.class == Aws::S3::Types::HeadObjectOutput
        rescue Aws::S3::Errors::NotFound => e
          if s3_client.debug_mode
            puts "bucket: #{id} with key #{key} not found."
          else
            return false
          end
      end

      # def get_object(id, key)
      #   res = s3_client.head_object({
      #                                 bucket: id,
      #                                 key: key
      #                               })
      #   res.data.class == Aws::S3::Types::HeadObjectOutput
      #   rescue Aws::S3::Errors::NotFound => e
      #     if s3_client.debug_mode
      #       puts "bucket: #{id} with key #{key} not found."
      #     else
      #       return false
      #     end
      # end

      def put_object(id, key, body, server_side_encryption)
        res = s3_client.put_object({
                                      bucket: id,
                                      key: key,
                                      server_side_encryption: server_side_encryption,
                                      body: body
                                    })
        rescue Aws::S3::Errors::AccessDenied => e
          puts "error: #{e.inspect}"
          false
      end

      def put_prefix(id, key, server_side_encryption)
        res = s3_client.put_object({
                                      bucket: id,
                                      key: key,
                                      server_side_encryption: server_side_encryption
                                    })
        rescue Aws::S3::Errors::AccessDenied => e
          puts "error: #{e.inspect}"
          false
      end

      def delete_object(id, key)
        res = s3_client.delete_object({
                                      bucket: id,
                                      key: key
                                    })
        rescue Aws::S3::Errors::AccessDenied => e
          puts "error: #{e.inspect}"
          false
      end

      def list_bucket(id, prefix=nil)
        res = s3_client.list_objects_v2({
                                          bucket: id,
                                          prefix: prefix
                                        })
        res.data.class == Aws::S3::Types::ListObjectsV2Output
      rescue Aws::S3::Errors::AccessDenied
        false
      end

      def find_bucket_cors(id)
        s3_client.get_bucket_cors(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_policy(id)
        s3_client.get_bucket_policy(bucket: id)
      rescue Aws::S3::Errors::ServiceError
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
