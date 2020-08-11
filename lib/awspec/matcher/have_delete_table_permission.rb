RSpec::Matchers.define :have_nuke_table_permission do
  match do |glue|
    puts "inside matcher: d-#{@database} t-#{@table}"
    glue.has_nuke_table_permission?(database: @database, table: @table)
  end

  chain :on_database do |database|
    @database = database
  end

  chain :for_table do |table|
    @table = table
  end

end
