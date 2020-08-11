RSpec::Matchers.define :have_create_table_permission do
  match do |glue|
    puts "inside matcher: d-#{@database} t-#{@table}"
    glue.has_create_table_permission?(database: @database, table: @table, description: @description)
  end

  chain :on_database do |database|
    @database = database
  end

  chain :for_table do |table|
    @table = table
  end

  chain :with_description do |description|
    @description = description
  end
end
