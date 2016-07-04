# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dctmclient/version'

Gem::Specification.new do |spec|
  spec.name          = "dctmclient"
  spec.version       = Dctmclient::VERSION
  spec.authors       = ["SunnyF"]
  spec.email         = ["sunny.feng@emc.com"]

  spec.summary       = 'A client sample written in Ruby to consume the Documentum REST Services.'
  spec.description   = 'Based on rest-client, which is a gem encapsulating HTTP verbs, this sample provides Ruby APIs to consume Documentum REST Services. '
  spec.homepage      = "http://rubygems.org/dctmclient."
  spec.license       = "Apache 2.0"

  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files         = [
    "lib/dctmclient.rb",
    "lib/dctmclient/version.rb",
    "lib/dctmclient/error/exception.rb",
    "lib/dctmclient/net/request.rb",
    "lib/dctmclient/net/response.rb",
    "lib/dctmclient/resources/home_demo.rb",
    "lib/dctmclient/resources/cabinet.rb",
    "lib/dctmclient/resources/child_link.rb",
    "lib/dctmclient/resources/document.rb",
    "lib/dctmclient/resources/folder.rb",
    "lib/dctmclient/resources/format.rb",
    "lib/dctmclient/resources/group_user.rb",
    "lib/dctmclient/resources/group.rb",
    "lib/dctmclient/resources/network_location.rb",
    "lib/dctmclient/resources/object_content.rb",
    "lib/dctmclient/resources/parent_link.rb",
    "lib/dctmclient/resources/relation_type.rb",
    "lib/dctmclient/resources/relation.rb",
    "lib/dctmclient/resources/repository.rb",
    "lib/dctmclient/resources/sub_group.rb",
    "lib/dctmclient/resources/sys_object.rb",
    "lib/dctmclient/resources/type.rb",
    "lib/dctmclient/resources/user.rb",
    "lib/dctmclient/resources/version.rb",
    "lib/dctmclient/resources/batch_capabilities.rb",
    "lib/dctmclient/resources/product_info.rb",
    "lib/dctmclient/resources/content_media.rb",
    "lib/dctmclient/resources/base/resource.rb",
    "lib/dctmclient/resources/base/link.rb"    
  ]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  
  spec.add_development_dependency "rest-client", "~> 1.8"
  spec.add_development_dependency "json", "~> 1.8"
  spec.add_development_dependency "awesome_print", "~> 1.7"
  
  spec.required_ruby_version = ">= 2.0.0"
end
