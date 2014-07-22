# lita-cookbook

Installs and configures the [lita](https://www.lita.io/) chatbot.

## Supported Platforms

* Ubuntu
 * 12.04 (precise)
 * 14.04 (precise)

Probably works on other Ubuntu version

## Tunable Attributes

All tunable attributes are in the `lita` heirarchy.

Key | Type | Description | Default
:---|:---|:---|:---
`name` | String  | Name of chatbot | Lita Chatbot
`config_coookbook` | String  | Name of cookbook where config template stored | lita (current)
`config_template` | String  | Name of config template file | lita (current)
`locale` | Symbol  | Language to use | :en
`log_level` | Symbol  | Locale | :en
`admin` | Array of Strings  | Adapter specific IDs of Lita admins | empty
`adapter` | Symbol  | Adapter to use for Lita instance | :shell
`adapter_version` | Fixed  | Version of adapter to use | nil (latest)
`adapter_config` | Hash  | Hash of adapter specific configuration | emtpy
`plugins` | Array of String and/or Hashes  | List of plugins to install and, optionally, versions of plugin to install | empty
`plugin_config` | Hash of Hashes  | Hash of plugin specific configuration | empty
`redis_host` | String  | IP address of redis instance | 127.0.01
`redis_port` | Numeric  | Port of redis instance | 6379
`install_dir` | String  | Lita home directory | /opt/lita
`log_dir` | String  | Lita log directory | /opt/lita/logs
`run_dir` | String  | Lita var/run directory | /opt/lita/run
`daemon_user` | String  | User to run daemon as | nobody
`ruby_install_type` | String  | How to install ruby depedency | auto
`redis_install_type` | String  | How to install redis depedency | auto

## Usage

### lita::default

Installs and configures the lita chatbot.

## Configuration

### Adapter

To make this effective you'll need to choose a non-default adapter from the [Lita plugin page](https://www.lita.io/plugins). The ```:shell``` adapter will not startup in daemon mode so the only way to test with it is to spin up a node, change into the ```node["lita"]["install_dir"]``` and run ```lita```

### Adapter Configuration

The adapter config is simply key/value pairs. If you need more complicated ruby configuratino (as some adapters do) you'll likely want to create a wrapper cookbook and set the ```config_cookbook``` and ```config_template``` attributes to your own template.

### Plugins

Plugins can be listed in an arry or, optionally listed as an array of hashes using plugin name as the key and Gemfile dependency syntax:

```ruby
 default["lita"]["plugins"] = [
  "ping",
  { "jenkins" => ">= 0.0.1" }
]
```

### Plugin Configuration

The plugins can be configured with a hashe of hashes that are keyed off the plugin name:

```ruby
default["lita"]["plugin_config"] = {
  "jenkins" => {
    "url" => "http://test.com"
    "auth" => ""user1:sekret""
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