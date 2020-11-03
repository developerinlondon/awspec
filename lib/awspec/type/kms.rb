module Awspec::Type
  class Kms < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_kms_key_by_alias(@display_name)
    end

    def id
      @id ||= resource_via_client.arn if resource_via_client
    end

    def enabled?
      resource_via_client.enabled
    end

    def has_valid_key_policy?()
      res = kms_client.get_key_policy(key_id: id, policy_name: 'default')
      policy = JSON.parse(URI.decode(res.policy))
      print("Policy is : #{policy}")
      print("Policy Statement is: #{policy["Statement"]}")
      policy["Statement"].each do |statement|
        print "Principal is #{statement["Principal"]["AWS"]}\n"
        # statement["Principal"]["AWS"].each do |principal|
        #   print "Principal is #{principal}\n"
        # end
      end
      return true
    end

    def has_key_policy?(policy_name, document = nil)
      res = kms_client.get_key_policy(key_id: id, policy_name: policy_name)
      return JSON.parse(URI.decode(res.policy)) == JSON.parse(document) if document
      res
    end
  end
end
