RSpec::Matchers.define :have_create_database_permission do
    match do |glue|
      glue.has_create_database_permission?(database: @databasename)
    end
  
    chain :for_database do |databasename|
      @databasename = databasename
    end
  
  end
  