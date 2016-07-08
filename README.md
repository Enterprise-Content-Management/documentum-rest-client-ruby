# documentum-rest-client-ruby
[![License: Apache 2](https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg)](http://www.apache.org/licenses/LICENSE-2.0)

Reference implementation of a Ruby client for accessing Documentum REST Services

## Installation
a. Download the source code from this repository on Github.
b. Open the the folder *documentum-rest-client-ruby* and build it which will produce a gem file.
```ruby
gem build dctmclient.gemspec
``` 
c. Install the gem in your local ruby gems repository.
```ruby
sudo gem install ./dctmclient-0.1.0.gem
``` 
d. Generate the documentation.(This step is optional)
```ruby
sudo gem rdoc --rdoc --overwrite dctmclient
```

## Usage 

### Basic
REST Services provides many resources, in spite of collection or single ones, therefore, we also have defined some classes corresponding to the resources, i.e., Repositories/Repository, Users/User, Cabinets/Cabinet, with relative APIs to realize some operations like CRUD.

To use it, a Home object, initialized with a URL directed to REST home page, is the only entry point to consume REST Services.  
```ruby
require 'dctmclient'

include Dctmclient

home = Home.new('http://localhost:8080/dctm-rest/services')

product_info = home.product_info

repositories = home.repositories

repository = repositories.find('repo_name', 'username', 'password')

batch_capabilities = repository.batch_capabilities

cabinets = repository.cabinets

checked_objects = repository.checked_out_objects

current_user = repository.current_user

formats = repository.formats

groups = repository.groups

network_locations = repository.network_locations

relation_types = repository.relation_types

relations = repository.relations

types = repository.types 

users = repository.users
```
###Navigation
Below codes style indicates the concept of navigation that if you want to access a resource, you have to gain its father resource. 
```ruby
repository = Home.new('http://localhost:8080/dctm-rest/services').repositories.find('repo', 'username', 'password'
-> Home-->Repositories-->Repository

repository.cabinets.find(cabinet_name).folders.find(folder_id).sys_objects.find(object_id)
-> Repository-->Cabinets-->Cabinet-->Folders-->Folder-->SysObjects-->SysObject
```

###CRUD
The majority of APIs exposed to user are to realize the CRUD(create, read, update, delete) against resources.
```ruby
cabinets = repository.cabinets

cabinet = cabinets.find('0c00000180001af0')

cabinet = cabinets.create({"properties" => {"object_name" => "test_cabinet"}})

cabinet = cabinet.update({"properties" => {"object_name" => "test_x_cabinet"}})

cabinet.delete


sys_objects = repository.cabinets.find('REPO').folders.find('test_folder').sys_objects

sys_object = sys_objects.find('090000018000151a')

sys_object = sys_objects.create({"properties" => {"object_name" => "test_object"}})

sys_object = sys_object.update({"properties" => {"object_name" => "test_x_object"}})

sys_object.delete
```
### Passing Query Params
We can specify some parameters to config the reuqest while accessing to Documentum REST Services.
```ruby
repository = Home.new('http://localhost:8080/dctm-rest/services').repositories.find('repo', 'username', 'password')

repository.users("include-total" => true, "view" => "object_name,r_object_id", "sort" => "object_name")

-> GET http://localhost:8080/dctm-rest/repositories/repo/users?include-total=true&view=object_name,r_object_id&sort=object_name
```

### Search
```ruby
dql = 'select * from dm_document'
repository.query_by(dql, "include-total" => true)

repository.search_by_query_params("q" => "REST")
```
###Pagination
Given collection resource, we have provided four APIs to realize the pagination access. Meanwhile, you can pass the relative query params to get a concrete page resource.
```ruby
users = repository.users("items-per-page" => 2)

users = users.first
users = users.next
users = users.previous
users = users.last

users = repository.users("items-per-page" =>2, "page" => 2)
```
###Check Out/In
```ruby
sys_object = sys_objects.find('0800000180001185')

sys_object = sys_object.checkout
sys_object.cancel_checkout

sys_object = sys_object.current_version

sys_object = sys_object.checkout
sys_object = sys_object.checkin_next_major('file content')

sys_object = sys_object.checkout
sys_object.checkin_next_minor('file content')
```
###Exception
```ruby
#assume user dave doesn't exist 
repository.users.find('dave')

-> Dctmclient::NavigationException


repository = Home.new('http://localhost:8080/dctm-rest/services').repositories.find('REPO', 'invalid-username', 'invalid-password')

-> Dctmclient::RequestException
```
###Raw Response
The purpose of these APIs is to consume Documentum REST Services, hence, a common public API *raw_response_from_rest_services* can be invoked by all the resouces(s) classes objects to get the detailed response from REST Server.  
```ruby
users = repository.users("include-total" => true)

users.raw_response_from_rest_services

->{:code => 200, :body => ..., headers => {...}}
```
