class BatchesController < ApplicationController

  def index
    if params[:batches]
      batches = params[:batches].split(',').uniq
      operations = []

      get_types_op_index = batches.index('types')
      operations.fill(get_types_operation, get_types_op_index, 1)

      get_relations_op_index = batches.index('relations')
      operations.fill(get_relations_operation, get_relations_op_index, 1)

      get_formats_op_index = batches.index('formats')
      operations.fill(get_formats_operation, get_formats_op_index, 1)

      @rest_batch_result = @@repo.execute_batch(default_config, operations)
    end
  end


  private

  def default_config
    {
        'transactional' => true,
        'sequential' => true,
        'on-error' => "CONTINUE",
        'return-request' => false
    }
  end


  def get_formats_operation
    {
        "id" => "get-formats",
        "request" => {
            "method" => "GET",
            "uri" => "/repositories/REPO/formats?items-per-page=10&inline=true",
            "headers" => [
                {
                    "name" => 'Content-Type',
                    "value" => "application/vnd.emc.documentum+json"
                },
                {
                    "name" => 'Accept',
                    "value" => "application/vnd.emc.documentum+json"
                }

            ]
        }
    }
  end

  def get_types_operation
    {
        "id" => "get-types",
        "request" => {
            "method" => "GET",
            "uri" => "/repositories/REPO/types?items-per-page=10&inline=true",
            "headers" => [
                {
                    "name" => 'Content-Type',
                    "value" => "application/vnd.emc.documentum+json"
                },
                {
                    "name" => 'Accept',
                    "value" => "application/vnd.emc.documentum+json"
                }

            ]
        }
    }
  end

  def get_relations_operation
    {
        "id" => "get-relations",
        "request" => {
            "method" => "GET",
            "uri" => "/repositories/REPO/relations?items-per-page=10&inline=true",
            "headers" => [
                {
                    "name" => 'Content-Type',
                    "value" => "application/vnd.emc.documentum+json"
                },
                {
                    "name" => 'Accept',
                    "value" => "application/vnd.emc.documentum+json"
                }

            ]
        }
    }
  end


end
