module Awspec::Type
  class SsmParameter < ResourceBase
    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_ssm_parameter(@display_name)
    end

    def id
      @id ||= @display_name if resource_via_client
    end

    def encrypted?
      resource_via_client.type.eql? 'SecureString'
    end

    def has_tag?(key, value)
      tag = find_parameter_tag(id, key)
      return nil if tag.value != value
      tag
    end

    def has_get_ssm_parameter_permission?
      get_ssm_parameter(id)
    end

    def has_describe_ssm_parameter_permission?
      find_ssm_parameter(id)
    end

  end
end
