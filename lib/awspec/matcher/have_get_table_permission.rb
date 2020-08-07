RSpec::Matchers.define :have_get_table_permission do
  match do |glue|
    glue.has_get_table_permission?(database: @database, table: @table)
  end

  chain :on_database do |database|
    @database = database
  end

  chain :for_table do |table|
    @table = table
  end
end
