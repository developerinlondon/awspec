RSpec::Matchers.define :have_update_table_permission do
  match do |glue|
    glue.has_update_table_permission?(database: @database, table: @table, description: @description, columns: @columns, partition_keys: @partition_keys)
  end

  chain :on_database do |database|
    @database = database
  end

  chain :for_table do |table|
    @table = table
  end

  chain :with_new_description do |description|
    @description = description
  end

  chain :with_columns do |columns|
    @columns = columns
  end

  chain :with_partition_keys do |partition_keys|
    @partition_keys = partition_keys
  end
end
