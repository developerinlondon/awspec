module Awspec::Type
  class VpcEndpoints < ResourceBase
    aws_resource Aws::EC2::Types::VpcEndpoint
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_vpc_endpoint(@display_name)
    end

    def id
      @id ||= resource_via_client.vpc_endpoint_id if resource_via_client
    end

    STATES = %w(
      pendingacceptance pending available deleting
      deleted rejected failed expired
    )

    STATES.each do |state|
      define_method state + '?' do
        resource_via_client.state == state
      end
    end

    def has_route_table?(route_table_id)
      rts = resource_via_client.route_table_ids

      ret = rts.find do |rt|
        rt == route_table_id
      end
      return true if ret
    end

    def has_subnet?(subnet_id)
      subnets = resource_via_client.subnet_ids

      ret = subnets.find do |subnet|
        subnet == subnet_id
      end
      return true if ret
    end

    def has_valid_vpce_policy?(iam_regex)
      retval = true
      policy = JSON.parse(resource_via_client.policy_document)
      policy["Statement"].each do |statement|
        if statement["Principal"] == "*" then
          retval = false
          print "Invalid Principal '*' in Sid #{statement['Sid']}\n"
        elsif statement["Principal"]["AWS"].kind_of?(Array) then
          statement["Principal"]["AWS"].each do |principal|
            unless principal.match(iam_regex) then
              retval = retval && false
              print "Invalid Principal #{principal} in Sid #{statement['Sid']}\n"
            end
          end
        else
          unless statement["Principal"]["AWS"].match(iam_regex) then
            retval = retval && false
            print "Invalid Principal #{statement["Principal"]["AWS"]} in Sid #{statement['Sid']}\n"
          end
        end
      end
      return retval
    end
  end
end
