module Dctmclient
  module Resources
    class AbstractSingleResource < AbstractResource
      def id
        return nil if representation_json.nil? || representation_json['properties'].nil?
        representation_json['properties']['r_object_id']
      end
    end
  end
end