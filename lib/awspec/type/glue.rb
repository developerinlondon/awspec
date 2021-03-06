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

    def has_create_database_permission?(database:)
      create_database(id, database)
    end

    def has_delete_database_permission?(database:)
      delete_database(id, database)
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

    def has_create_table_permission?(database:, table:, description:, columns:, partition_keys:)
      create_table(id, database, table, description, columns, partition_keys)
    end

    def has_update_table_permission?(database:, table:, description:, columns:, partition_keys:)
      update_table_description(id, database, table, description, columns, partition_keys)
    end

    def has_delete_table_permission?(database:, table:)
      delete_table(id, database, table)
    end

  end
end
