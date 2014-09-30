# lita - core configuration

# The name your robot will use.
default["lita"]["name"] = "Lita Chatbot"

# The name Lita will look for in messages to determine if the message is being
# addressed to it. Usually this is the same as the display name, but in some
# cases it may not be. For example, in HipChat, display names are required to
# be a first and last name, such as "Lita Bot", whereas the mention system
# would use a name like "LitaBot".
default["lita"]["mention_name"] = node["lita"]["name"]

# The cookbook to find the config template (allows for wrapper cookbooks to
# override with custom template for more complex configurations)
default["lita"]["config_cookbook"] = "lita"
default["lita"]["config_template"] = "lita_config.rb.erb"

# The locale code for the language to use.
default["lita"]["locale"] = :en

# The severity of messages to log. Options are:
# :debug, :info, :warn, :error, :fatal
# Messages at the selected level and above will be logged.
default["lita"]["log_level"] = :info

# An array of user IDs that are considered administrators. These users
# the ability to add and remove other users from authorization groups.
# What is considered a user ID will change depending on which adapter you use.
default["lita"]["admin"] = []

# The adapter you want to connect with. Recipe will auto-install any adapter
# found here: https://www.lita.io/plugins
default["lita"]["adapter"] = :shell

# The adapter version to install (using Gemfile format); nil for latest
default["lita"]["adapter_version"] = nil

# Configuration specific to adapter above:
default["lita"]["adapter_config"] = {}

# Array of plugin to install OR hashes of plugins and Gemfile formatted line
# Example:
#
# default["lita"]["plugins"] = [
#  "ping",
#  { "jenkins" => ">= 0.0.1" }
#  { "foo" => ">= 1.2.3, :git => 'git://github.com/foo/foo.git'" }
# ]
#
default["lita"]["plugins"] = []

# Array of extra gems to install OR hashes of gems and Gemfile formatted line
# See above for example.
default["lita"]["gems"] = []

# Configuration specific to plugin list above. Example:
#
# default["lita"]["plugin_config"] = {
#   "jenkins" => {
#     "url" => "http://test.com"
#     "auth" => ""user1:sekret""
#   }
# }
#
default["lita"]["plugin_config"] = {}

# helpful for adding native libs needed by adapters / handlers
default["lita"]["packages"] = %w(
  openssl
  libssl-dev
  ca-certificates
  libcurl4-gnutls-dev
)

# Set options for redis connection
default["lita"]["redis_host"] = "127.0.0.1"
default["lita"]["redis_port"] = 6379

# Set options for http server
default["lita"]["http_host"]        = "0.0.0.0"
default["lita"]["http_port"]        = 8080
default["lita"]["http_min_threads"] = 0
default["lita"]["http_max_threads"] = 16

# directories, files, etc.
default["lita"]["install_dir"] = "/opt/lita"
default["lita"]["log_dir"]     = "/opt/lita/logs"
default["lita"]["run_dir"]     = "/opt/lita/run"

# daemon user - must already exist
default["lita"]["daemon_user"] = "nobody"

# dependency install type:
#
# - auto: let the cookbook try to figure it out
# - none: will be installed by other means and available in system path
#
default["lita"]["ruby_install_type"]  = "auto"
default["lita"]["redis_install_type"] = "auto"
