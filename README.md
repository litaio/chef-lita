# lita-cookbook

Installs and configures the [lita](https://www.lita.io/) chatbot.

*NOTE: Beginning with v1.0.0, the Lita service is controlled using runit instead of the SysV init style script. To use v1.0.0 and maintain the use of the SysV init style script, see the `init_style` attribute below*

## Supported Platforms

* Ubuntu
 * 12.04 (precise)
 * 14.04 (trusty)
* CentOS
 * 7 (NOTE: Will not work with `auto` setting of `redis_install_type`. You must handle Redis outside of this cookbook. Working on fixing this.)

It will likely work on other Ubuntu versions, however the automatic methods of installing ruby and redis will have issues.

## Tunable Attributes

All tunable attributes are in the `lita` heirarchy.

Key | Type | Description | Default
:---|:---|:---|:---
`name` | String  | Name of chatbot | Lita Chatbot
`mention_name` | String | Name chatbot listens for | Value of `name`
`alias` | String | Name chatbot listens for that is shorter than `mention_name` | empty
`version` | String  | Gemfile-style version dependency of lita to install | nil (latest)
`config_coookbook` | String  | Name of cookbook where config template stored | lita (current)
`config_template` | String  | Name of config template file | lita_config.rb.erb
`gemfile_template` | String  | Name of Gemfile template file (uses same cookbook as `config_cookbook` | Gemfile.erb
`service` | Array of Strings | Service actions to take on service | `[:enable, :start]`
`init_style` | String | Type of init to use. Supported: init, runit | runit
`init_template` | String  | Name of SysV init file (uses same cookbook as `config_cookbook`) | lita.erb
`runit['finish']` | Boolean | Enable the finish script for the runit service | false
`runit['env']` | Hash | Environment variables to pass to runit service | see attributes/default.rb
`locale` | String/Symbol  | Language to use | ":en"
`log_level` | String/Symbol  | Locale | ":info"
`admin` | Array of Strings  | Adapter specific IDs of Lita admins | empty
`adapters` | Array of Strings/Symbols  | Adapters to use for Lita instance | [:shell]
`adapter_versions` | Hash of Fixed  | Versions of adapter to use | { :shell => nil } (latest)
`adapter_config` | Hash of Hashes | Hashes of adapter specific configurations | empty
`plugins` | Array of Strings and/or Hashes  | List of plugins to install and, optionally, Gemfile line options | empty
`plugin_config` | Hash of Hashes  | Hash of plugin specific configuration | empty
`gems` | Array of Strings and/or Hashes  | List of gems to install and, optionally, Gemfile line options | empty
`gem_primary_source` | String | Source URL for Gemfile `source` | `https://rubygems.org`
`packages` | Array of Strings | List of system packages to install | SSL related stuff
`http_host` | String  | IP address to bind http server | 0.0.0.0
`http_port` | Numeric  | Port to bind http server | 8080
`http_min_threads` | Numeric  | Min number of http threads | 0
`http_max_threads` | Numeric  | Max number of http threads | 0
`redis_host` | String  | IP address of redis instance | 127.0.0.1
`redis_port` | Numeric  | Port of redis instance | 6379
`install_dir` | String  | Lita home directory | /opt/lita
`log_dir` | String  | Lita log directory | /opt/lita/logs
`run_dir` | String  | Lita var/run directory | /opt/lita/run
`daemon_user` | String  | User to run daemon as | nobody
`daemon_group` | String  | Group to run daemon as | nogroup
`ruby_install_type` | String  | How to install ruby depedency | auto
`redis_install_type` | String  | How to install redis depedency | auto

### Important Note

It turns out that creating a valid ruby file from Chef attributes is trickier than I originally thought. Attributes can be added to the node object via JSON strings (node attributes or environment/role in JSON form) or Ruby methods (wrapper cookbooks or the ruby version of environments/roles). There is a library file called ```helpers.rb``` which includes the ```typecast``` method which is used in the ```lita_config.rb.erb``` template to build out valid ruby configuration.

This method is new and I've tested it with contrived data. However, if you find a situation that doesn't work, you can can create a wrapper cookbook and set the ```config_cookbook``` and ```config_template``` attributes to your own template. Then be sure to notify me through GitHub issues and I'll attempt to adjust the method to support whatever case I missed.

## Usage

### lita::default

Installs and configures the lita chatbot.

If used in a wrapper cookbook and a need for fine grained control over the configuration and init files, see the attributes `config_cookbook`, `config_template`, `gemfile_template`, and `init_template`. The `config_cookbook` parameter sets the cookbook to find the other template files.

Example:

```
# mycompany-lita/recipes/default.rb

node.default["lita"]["config_cookbook"]  = "mycompany-lita"
node.default["lita"]["config_template"]  = "mycustom_lita_config.rb.erb"
node.default["lita"]["gemfile_template"] = "mycustom_Gemfile.erb"
node.default["lita"]["init_template"]    = "mycustom_lita.erb"
include_recipe "lita::default"
```

## Configuration

### Adapter

To make this effective you'll need to choose a non-default adapter from the [Lita plugin page](https://www.lita.io/plugins). The ```:shell``` adapter will not startup in daemon mode so the only way to test with it is to spin up a node, change into the ```node["lita"]["install_dir"]``` and run ```bin/lita```

### Adapter Configuration

The adapter config now supports complex ruby data types (i.e. hashes, hash of arrays, etc.)

### Plugins

Plugins can be listed in an array or, optionally listed as an array of hashes using plugin name as the key and Gemfile line syntax:

```ruby
default["lita"]["plugins"] = [
  "ping",
  { "jenkins" => ">= 0.0.1" }
  { "foo" => ">= 1.2.3, :git => 'git://github.com/foo/foo.git'" }
  { "bar" => ":path => '/path/to/local/plugin/lita-bar'" }
]
```

The above example has four different ways to install / manage plugins:

* the latest version of the `lita-ping` plugin from rubygems.org
* the version greater than `0.0.1` of `lita-jenkins` plugin from rubygems.org
* the repository for foo-lita from git want having version greater than or equal to `1.2.3` (This could be public or private depending on whether the node/user has access to git.)
* A local plugin called 'lita-bar' on the filesystem of the lita node found at the path `/path/to/local/plugin/lita-bar`

### Plugin Configuration

The plugins can also be configured with complex data types in ruby or json:

```ruby
default["lita"]["plugin_config"] = {
  "foo" => {
    "bar" => {
      "key1" => "val1"
    }
  }
}
```

```json
{
  "lita": {
    "plugin_config": {
      "foo": {
        "bar": {
          "key1": "val1"
        }
      }
    }
  }
}
```

It can even take a string that looks like a hash and convert it appropriately:


```json
{
  "lita": {
    "plugin_config": {
      "foo": "{ \"bar\": { \"key1\": \"val1\" } }"
    }
  }
}
```

### Ruby and Redis

Lita [requires recent versions](http://docs.lita.io/getting-started/installation/) of Ruby and Redis. By default, the ```lita``` cookbook will automatically try to find appropriate ruby and redis versions for your platform and version.

To install those dependencies yourself, simple set the install type attributes to ```none``` as such:

```ruby
node.default["lita"]["ruby_install_type"] = "none"
node.default["lita"]["redis_install_type"] = "none"
```

If these versions don't work for you (or the cookbook doesn't currently support your platform/version), you can manage the installation of ruby and redis yourself through various methods:

* Add ruby and redis using community cookbooks in your node/role run_list
* Creating a wrapper cookbook that does the same
* Using a base image that already includes the dependencies

The only requirement for the ```lita``` cookbook is that ```ruby```, ```gem``` and ```bundler``` are in the system path and provide the appropriate versions to work with lita.

## Example

Here's an example node configuration for leveraging ```lita-hipchat```:

```json
{
  "lita": {
    "adapters": ["hipchat"],
    "adapter_config": {
      "hipchat": {
        "jid": "99999_0000000@chat.hipchat.com",
        "password": "sekret1",
        "rooms": ":all",
        "muc_domain": "conf.hipchat.com"
      }
    },
    "gems": {
      "pagerduty-sdk", ":git => \"https://github.com/kryptek/pagerduty-sdk.git\""
    },
    "plugins": [
      "jenkins",
      "pagerduty",
      "cron",
      "dig",
      "youtube",
      "xkcd",
      "jenkins",
      "wikipedia"
    ],
    "plugin_config": {
      "jenkins": {
        "url": "http://jenkins.notreally.com/",
        "auth": "lita:sekret1"
      },
      "pagerduty": {
        "api_key": "kkkkkkkkkkkkkkkkkkkkkk",
        "subdomain": "notreally"
      }
    }
}
```

## License and Authors

- Author:: Harlan Barnes (<hbarnes@pobox.com>)

```text
Copyright:: 2014 Harlan Barnes

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
