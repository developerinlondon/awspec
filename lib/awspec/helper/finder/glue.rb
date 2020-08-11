module Awspec::Helper
  module Finder
    module Glue
      def get_catalog(id)
        glue_client.get_data_catalog_encryption_settings({
          catalog_id: "#{id}",
        })
        rescue Aws::Glue::Errors::AccessDenied => e
          nil
      end

      def get_databases(id)
        resp = glue_client.get_databases({
          catalog_id: "#{id}"
        })
        resp.database_list.count
        rescue Aws::Glue::Errors::AccessDeniedException => e
          false
      end

      def get_database(id, name)
        glue_client.get_database({
          catalog_id: "#{id}",
          name: "#{name}"
        })
        rescue Aws::Glue::Errors::AccessDeniedException => e
          false
      end

      def get_tables(id, databasename)
        resp = glue_client.get_tables({
          catalog_id: "#{id}",
          database_name: "#{databasename}"
        })
        resp.table_list.count
        rescue Aws::Glue::Errors::AccessDeniedException => e
          false
      end

      def get_table(id, databasename, tablename)
        glue_client.get_table({
          catalog_id: "#{id}",
          database_name: "#{databasename}",
          name: "#{tablename}"
        })
        rescue Aws::Glue::Errors::AccessDeniedException => e
          false
      end

      def create_table(id, databasename, tablename, description = "")
        resp = glue_client.create_table({
          catalog_id: "#{id}",
          database_name: "#{databasename}", # required
          table_input: { # required
            name: "#{tablename}",
            description: "#{description}"
          }
        })
        rescue Aws::Glue::Errors::AccessDeniedException => e
          false
      end

      def update_table_description(id, databasename, tablename, description)
        resp = glue_client.update_table({
          catalog_id: "#{id}",
          database_name: "#{databasename}", # required
          table_input: { # required
            name: "#{tablename}", # required
            description: "#{description}"
          }
        })
        rescue Aws::Glue::Errors::AccessDeniedException => e
          false
      end

      def delete_table(id, databasename, tablename)
      puts "delete helper: database is #{databasename} and table is #{tablename}"
        resp = glue_client.delete_table({
          catalog_id: "#{id}",
          database_name: "#{databasename}", # required
          name: "#{tablename}"
        })
        rescue Aws::Glue::Errors::AccessDeniedException => e
          false
      end

    end
  end
end
