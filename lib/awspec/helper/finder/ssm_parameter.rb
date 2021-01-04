module Awspec::Helper
  module Finder
    module SsmParameter
      def find_ssm_parameter(name)
        begin
          ssm_client.describe_parameters(
            {
              filters:  [
                {
                  key: 'Name',
                  values: [name]
                }
              ]
            }).parameters[0]
          rescue Aws::SSM::Errors::ThrottlingException
            sleep 0.5
            puts "retrying after sleeping 0.5 seconds\n"
            ssm_client.describe_parameters(
              {
                filters:  [
                  {
                    key: 'Name',
                    values: [name]
                  }
                ]
              }).parameters[0]
          end
      end

      def find_parameter_tag(id, tag_key)
        tag = nil
        begin
          response = ssm_client.list_tags_for_resource(
            resource_type: 'Parameter',
            resource_id: id
          )
          tag_set = response.tag_list
          tag = tag_set.find { |tag_obj| tag_obj.key == tag_key }
        rescue Aws::SSM::Errors::ServiceError
          nil
        end
        return tag if tag
      end

      def get_ssm_parameter(name)
        begin
          response = ssm_client.get_parameter({
            name: name,
            with_decryption: false,
          })
        rescue Aws::SSM::Errors::ServiceError => e
          puts "error: #{e.inspect}"
          false
        end
      end

    end
  end
end
