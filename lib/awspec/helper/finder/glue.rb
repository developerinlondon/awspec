module Awspec::Helper
  module Finder
    module Glue
      def find_catalog(id)
        id
      end

      def find_database(id, name)
        glue_client.get_database({
          catalog_id: "#{id}",
          name: "#{name}"
        })
        rescue Aws::Glue::Errors::ServiceError => e
          puts "error: #{e.inspect}"
          false
      end

      def find_table(id, databasename, tablename)
        glue_client.get_table({
          catalog_id: "#{id}",
          database_name: "#{databasename}",
          name: "#{tablename}"
        })
        rescue Aws::Glue::Errors::ServiceError => e
          puts "error: #{e.inspect}"
          false
      end

    end
  end
end
