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

    def has_valid_key_policy?(iam_regex)
      retval = true
      res = kms_client.get_key_policy(key_id: id, policy_name: 'default')
      policy = JSON.parse(URI.decode(res.policy))
      policy["Statement"].each do |statement|
        if statement["Principal"]["AWS"].kind_of?(Array) then
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

    def has_principal_with_permission?(principal_regex, action_regex = nil)
      retval = false
      res = kms_client.get_key_policy(key_id: id, policy_name: 'default')
      policy = JSON.parse(URI.decode(res.policy))
      policy["Statement"].each do |statement|
        if statement["Principal"]["AWS"].kind_of?(Array) then
          statement["Principal"]["AWS"].each do |principal|
            return true if match_action(principal, statement["Action"], principal_regex, action_regex)
          end
        else
          return true if match_action(statement["Principal"]["AWS"], statement["Action"], principal_regex, action_regex)
        end
      end
      return retval
    end

    def has_key_policy?(policy_name, document = nil)
      res = kms_client.get_key_policy(key_id: id, policy_name: policy_name)
      return JSON.parse(URI.decode(res.policy)) == JSON.parse(document) if document
      res
    end
  end
end
