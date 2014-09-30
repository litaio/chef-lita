#
# Author:: Harlan Barnes (<hbarnes@pobox.com>)
# Cookbook Name:: lita
# Recipe:: default
#
# Installs and configures lita
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

include_recipe "apt::default"
include_recipe "build-essential::default"
include_recipe "lita::ruby"
include_recipe "lita::redis"

# things the rubygems / adapters / handlers might need
node["lita"]["packages"].each do |pkg|
  package pkg
end

%w( install_dir log_dir run_dir ).each do |dir|
  directory node["lita"][dir] do
    owner node["lita"]["daemon_user"]
    group node["lita"]["daemon_user"]
    mode "0755"
    action :create
  end
end

template "#{node["lita"]["install_dir"]}/Gemfile" do
  notifies :delete, "file[Gemfile.lock]", :immediately
  notifies :run, "execute[bundle-install-lita]", :immediately
  helpers do
    def stringify(attrib)
      if attrib =~ /^:/
        attrib[1..-1]
      else
        attrib
      end
    end
  end
end

file "Gemfile.lock" do
  action :nothing
  path "#{node["lita"]["install_dir"]}/Gemfile.lock"
end

execute "bundle-install-lita" do
  action :nothing
  command "bundle install --path vendor/ --binstubs bin"
  cwd node["lita"]["install_dir"]
  user node["lita"]["daemon_user"]
  notifies :run, "execute[chown-cleanup]", :immediately
  notifies :restart, "service[lita]"
end

# we have to run bundle as the daemon user but we don't want the daemon user
# to have write privs to the code and config.
execute "chown-cleanup" do
  command <<-EOF.gsub(/  /, '')
  chown root:root \
    #{node["lita"]["install_dir"]}; \
  chown -R root:root \
    #{node["lita"]["install_dir"]}/bin \
    #{node["lita"]["install_dir"]}/vendor \
    #{node["lita"]["install_dir"]}/.bundle \
    #{node["lita"]["install_dir"]}/Gemfile.lock
  EOF
  action :nothing
  notifies :restart, "service[lita]"
end

template "#{node["lita"]["install_dir"]}/lita_config.rb" do
  cookbook node["lita"]["config_cookbook"]
  source node["lita"]["config_template"]
  notifies :restart, "service[lita]"
  helpers (LitaHelpers)
end

template "/etc/init.d/lita" do
  mode "0755"
  notifies :restart, "service[lita]"
end

service "lita" do
  supports :status => true, :restart => true
  action [:enable, :start]
end
