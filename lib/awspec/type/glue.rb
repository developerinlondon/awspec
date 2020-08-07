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

    def has_get_database_permission?(database:)
      get_database(id, database)
    end

    def has_get_table_permission?(database:, table:)
      get_table(id, database, table)
    end

  end
end
