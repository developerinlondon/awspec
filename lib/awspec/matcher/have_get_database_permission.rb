RSpec::Matchers.define :have_get_database_permission do
  match do |glue|
    glue.has_get_database_permission?(database: @database)
  end

  chain :for_database do |database|
    @database = database
  end
end
