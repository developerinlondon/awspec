RSpec::Matchers.define :have_principal do |parameters|
    match do |key_type|
      @principal_regex = parameters[0]
      key_type.has_principal_with_permission?(@principal_regex, @permission)
    end

    chain :with_permission do |permission|
      @permission = permission
    end
  end
    