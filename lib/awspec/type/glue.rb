module Awspec::Type
  class Glue < ResourceBase
    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= get_catalog(@display_name)
    end

    def id
      @id ||= @display_name
    end

    def has_catalog?(catalog)
      check_existence
      get_catalog(catalog)
    end

    def has_get_databases_permission?()
      get_databases(id)
    end

    def has_get_database_permission?(database:)
      get_database(id, database)
    end

    def has_get_tables_permission?(database:)
      get_tables(id, database)
    end

    def has_get_table_permission?(database:, table:)
      get_table(id, database, table)
    end

    def has_create_table_permission?(database:, table:)
      create_table(id, database, table)
    end

    def has_update_table_permission?(database:, table:, new_table:)
      update_table(id, database, table, new_tablename)
    end
  end
end
