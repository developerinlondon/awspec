module Awspec::Helper
  module Finder
    module Glue
      def get_catalog(id)
        glue_client.get_data_catalog_encryption_settings({
          catalog_id: "#{id}",
        })
        rescue Aws::Glue::Errors::AccessDeniedException => e
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
            description: "#{description}",
            storage_descriptor: {
              columns: [
                  {
                      name: "col1_test",
                      type: "string"
                  },
                  {
                      name: "col2_test",
                      type: "bigint"
                  },
              ]
            },
            partition_keys: [
              {
                  name: "col11_test",
                  type: "date"
              },
              {
                  name: "col12_test",
                  type: "string"
              }
            ]
          },

        })
        rescue Aws::Glue::Errors::AccessDeniedException => e
          false
      end

      # def create_partition(id, databasename, tablename)
      #   resp = glue_client.create_partition({
      #     catalog_id: "#{id}",
      #     database_name: "#{databasename}",
      #     table_name: "#{tablename}",
      #     partition_input: {
      #       storage_descriptor: {
      #         columns: [
      #             {
      #                 name: "col1_test",
      #                 type: "string"
      #             },
      #             {
      #                 name: "col2_test",
      #                 type: "bigint"
      #             },
      #         ]
      #       },
      #       partition_keys: [
      #         {
      #             name: "col11_test",
      #             type: "date"
      #         },
      #         {
      #             name: "col12_test",
      #             type: "string"
      #         }
      #       ],
      #     }
      #   })
      # end

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
