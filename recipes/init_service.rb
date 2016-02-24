#
# Author:: Harlan Barnes (<hbarnes@pobox.com>)
# Cookbook Name:: lita
# Recipe:: init_service
#
# Installs and configures runit for lita
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

# build service values

case node['lita']['init_style']
when 'init'
  template "/etc/init.d/lita" do
    cookbook node["lita"]["config_cookbook"]
    source node["lita"]["init_template"]
    mode "0755"
    notifies :restart, "service[lita]"
  end
  service "lita" do
    supports :status => true, :restart => true
    action node['lita']['service']
  end
else
  include_recipe 'runit'

  lita_runit_env_default = {
    'HOME' => node['lita']['install_dir'],
    'PATH' => [node['languages']['ruby']['bin_dir'],
               node['languages']['ruby']['gem_bin'],
               node['languages']['ruby']['ruby_dir']
               ].join(':')
  }
  lita_runit_env = node['lita']['runit']['env'] || lita_runit_env_default

  runit_service 'lita' do
    cookbook node["lita"]["config_cookbook"]
    finish node['lita']['runit']['finish']
    env lita_runit_env
  end
end
