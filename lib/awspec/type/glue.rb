module Awspec::Type
  class Glue < ResourceBase

    def resource_via_client
      @resource_via_client ||= find_catalog(@id)
    end

    def id
      @id ||= @display_name
    end

    def has_catalog?(catalog)
      check_existence
    end

    def has_database?(databasename)
      return get_database(id, databasename)
    end

    def has_table?(database:, table:)
     get_table(id, database, table)
    end

  end
end
