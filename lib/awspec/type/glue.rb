module Awspec::Type
  class Glue < ResourceBase
    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= get_catalog(id)
    end

    def id
      @id ||= @display_name
    end

    def has_catalog?(catalog)
      check_existence
      get_catalog(catalog)
    end

    def has_database?(database)
      get_database(id, database)
    end

    def has_table?(database:, table:)
      get_table(id, database, table)
    end

  end
end
