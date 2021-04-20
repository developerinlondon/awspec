module Awspec::Helper
  module Finder
    module VpcEndpoints
      def find_vpc_endpoint(name)
        res = ec2_client.describe_vpc_endpoints({
                                         filters: [{ name: 'tag:Name', values: [name] }]
                                       })
        resource = res.vpc_endpoints[0]
      end
    end
  end
end
