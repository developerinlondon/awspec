RSpec::Matchers.define :have_principal do |parameters|
    match do |key_type|
      key_type.has_principal_with_permission?(parameters, @permission)
    end

    chain :with_permission do |permission|
      @permission = permission
    end
  end
    