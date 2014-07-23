# lita - core configuration

# The name your robot will use.
default["lita"]["name"] = "Lita Chatbot"

# The cookbook to find the config template (allows for wrapper cookbooks to
# override with custom template for more complex configurations)
default["lita"]["config_cookbook"] = "lita"
default["lita"]["config_template"] = "lita_config.rb.erb"

# The locale code for the language to use.
default["lita"]["locale"] = ":en"

# The severity of messages to log. Options are:
# :debug, :info, :warn, :error, :fatal
# Messages at the selected level and above will be logged.
default["lita"]["log_level"] = ":info"

# An array of user IDs that are considered administrators. These users
# the ability to add and remove other users from authorization groups.
# What is considered a user ID will change depending on which adapter you use.
default["lita"]["admin"] = []

# The adapter you want to connect with. Recipe will auto-install any adapter
# found here: https://www.lita.io/plugins
default["lita"]["adapter"] = ":shell"

# The adatpter version to install (using Gemfile format); nil for latest
default["lita"]["adapter_version"] = nil

# Configuration specific to adapter above:
default["lita"]["adapter_config"] = {}

# Array plugins OR hashes of plugins and versions (in Gemfile format) to install
# Example:
#
# default["lita"]["plugins"] = [
#  "ping",
#  { "jenkins" => ">= 0.0.1" }
# ]
#
#
default["lita"]["plugins"] = []

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

# Set options for redis connection
default["lita"]["redis_host"] = "127.0.0.1"
default["lita"]["redis_port"] = 6379

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
