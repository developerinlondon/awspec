RSpec::Matchers.define :have_create_table_partition_permission do
  match do |glue|
    puts "inside matcher: d-#{@database} t-#{@table}"
    glue.has_create_table_partition_permission?(database: @database, table: @table, partition: @partition)
  end

  chain :on_database do |database|
    @database = database
  end

  chain :for_table do |table|
    @table = table
  end

  chain :with_partition_name do |partition|
    @partition = partition
  end
end
