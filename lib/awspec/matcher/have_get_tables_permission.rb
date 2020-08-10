RSpec::Matchers.define :have_get_tables_permission do
  match do |glue|
    glue.has_get_tables_permission?(database: @database)
  end

  chain :for_database do |database|
    @database = database
  end

end
