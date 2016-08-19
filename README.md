# documentum-rest-client-ruby
[![License: Apache 2](https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg)](http://www.apache.org/licenses/LICENSE-2.0)

Reference implementation of a Ruby client for accessing Documentum REST Services

## What the demo demonstrates?
It will do the following jobs for some REST resources.
```
0. Get Users
1. Get Groups
2. Cabinet CRUD
3. SysObject CRUD
4. Simple Search
5. DQL 
6. Get BatchCapabilities
7. Get Checked Out Objects
8. Get Formats
```

## Requirements

1. Ruby 2.1.5+ suggested, earlier Ruby versions such as 1.8.x, and 1.9.x are no longer supported officially. Version 2.1.5 is used in this demo.
2. Rails 4.2.3+ suggested, a full stack framework for web application development. It's required for demo. 
3. An instance of *Documentum REST Services 7.2* is available.


## Instructions  
These following steps will direct you to how to run this demo from the scratch, including preparing the Ruby environment, building this project and starting the demo.
*Note*: below instructions are implemented only on Linux, and this demo has been tested on Ubuntu 14.04 when writing this document. 

1. Install some dependencies for Ruby

    ```
    $ sudo apt-get update
    $ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
    ```
    
2. Download and install [Ruby 2.x](https://www.ruby-lang.org/en/downloads/) from source code with make tool.

    ```
    $ cd ruby-2.x
    $ ./configure
    $ make
    $ sudo make install
    ```
     
3. Install rails framework (only required for demo)

    ```
    $ sudo gem install bundler
    $ sudo gem install rails
    ```
    
4. Navigate to the project home directory.

    ```
    $ cd documentum-rest-client-ruby 
    ```
    
5. Build the project, which would generates a file named *dctmclient-0.1.0.gem* locally.

    ```
    $ gem build dctmclient.gemspec
    ```
    
6. Install the generated gem into local lib.

    ```
    $ sudo gem install dctmclient-0.1.0.gem
    ```
     
7. Navigate to the demo/ruby-client-sample directory under this project.

    ```
    $ cd demo/ruby-client-sample
    ```
    
8. Start the sample application.

    ```
    $ sudo bundle update
    $ sudo bundle install
    $ rails s -b 0.0.0.0
    ```
    
9. Access *http://localhost:3000/home*

##Demo
<img src="demo/ruby-demo.gif" width="1000">

