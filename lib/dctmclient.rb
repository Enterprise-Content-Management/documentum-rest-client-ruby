require "dctmclient/version"

require_relative File.dirname(__FILE__) + '/dctmclient/exception/dctmclient_exception'

require_relative File.dirname(__FILE__) + '/dctmclient/net/request'
require_relative File.dirname(__FILE__) + '/dctmclient/net/response'

require_relative File.dirname(__FILE__) + '/dctmclient/resources/base/link'
require_relative File.dirname(__FILE__) + '/dctmclient/resources/base/resource'
require_relative File.dirname(__FILE__) + '/dctmclient/resources/base/single_resource'
require_relative File.dirname(__FILE__) + '/dctmclient/resources/base/collection_resource'


# require resources
Dir[
    File.dirname(__FILE__) + '/dctmclient/resources/single_resources/*.rb',
    File.dirname(__FILE__) + '/dctmclient/resources/collection_resources/*.rb'
].each { |file| require file }


module Dctmclient
end
