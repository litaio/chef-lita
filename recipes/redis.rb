#
# Author:: Harlan Barnes (<hbarnes@pobox.com>)
# Cookbook Name:: lita
# Recipe:: redis
#
# Installs and configures redis for lita
#
# Copyright 2014, Harlan Barnes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node["lita"]["redis_install_type"] == "auto"
  case node["platform_family"]
  when "debian", "rhel"
    node.default["redis2"]["install_from"] = "source"
    node.default["redis2"]["instances"]["default"]["bindaddress"] = node["lita"]["redis_host"]
    node.default["redis2"]["instances"]["default"]["port"] = node["lita"]["redis_port"]
    include_recipe "redis2::default_instance"
  else
    log "redis_install_type 'auto' could not find a redis for this platform"
  end
else
  log "redis will not be installed by lita cookbook"
end
