module Awspec::Helper
  module Finder
    module Glue
      def get_catalog(id)
        glue_client.get_data_catalog_encryption_settings({
          catalog_id: "#{id}",
        })
        rescue Aws::Glue::Errors::ServiceError => e
          nil
      end

      def get_databases(id)
        resp = glue_client.get_databases({
          catalog_id: "#{id}"
        })
        resp.database_list.count
        rescue Aws::Glue::Errors::ServiceError => e
          false
      end

      def get_database(id, name)
        glue_client.get_database({
          catalog_id: "#{id}",
          name: "#{name}"
        })
        rescue Aws::Glue::Errors::ServiceError => e
          false
      end

      def get_tables(id, databasename)
        resp = glue_client.get_tables({
          catalog_id: "#{id}",
          database_name: "#{databasename}"
        })
        resp.table_list.count
        rescue Aws::Glue::Errors::ServiceError => e
          false
      end

      def get_table(id, databasename, tablename)
        glue_client.get_table({
          catalog_id: "#{id}",
          database_name: "#{databasename}",
          name: "#{tablename}"
        })
        rescue Aws::Glue::Errors::ServiceError => e
          false
      end

      def create_table(id, databasename, tablename)
        resp = glue_client.create_table({
          catalog_id: "#{id}",
          database_name: "#{databasename}", # required
          table_input: { # required
            name: "#{tablename}", # required
            #description: "DescriptionString",
            owner: "NameString",
            last_access_time: Time.now,
            last_analyzed_time: Time.now,
            retention: 1,
            # partition_keys: [
            #   {
            #     name: "NameString", # required
            #     type: "ColumnTypeString",
            #     comment: "CommentString",
            #     parameters: {
            #       "KeyString" => "ParametersMapValue",
            #     },
            #   },
            # ],
            view_original_text: "ViewTextString",
            view_expanded_text: "ViewTextString",
            table_type: "TableTypeString",
            # parameters: {
            #   "KeyString" => "ParametersMapValue",
            # },
            target_table: {
              catalog_id: "#{id}",
              database_name: "#{databasename}",
              name: "#{tablename}",
            },
          },
        })

        # rescue Aws::Glue::Errors::ServiceError => e
        #   false
      end
    end
  end
end
