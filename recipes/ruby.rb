#
# Author:: Harlan Barnes (<hbarnes@pobox.com>)
# Cookbook Name:: lita
# Recipe:: ruby
#
# Installs and configures ruby for lita
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

if node["lita"]["ruby_install_type"] == "auto"
  case node["platform"]
  when "rhel"
    if node["platform_version"].to_f > 7.0
      package "ruby"
    else
      log "ruby_install_type 'auto' could not find a ruby for this rhel version"
    end
  when "ubuntu"
    case node["platform_version"]
    when "12.04"
      # 12.04 repos only have up to 1.9.1
      node.default["ruby-ng"]["ruby_version"] = "2.1"
      include_recipe "ruby-ng::default"

      package "ruby#{node['ruby-ng']['ruby_version']}-dev"
    when "14.04"
      # 14.04 repos have ruby 2.0
      %w(ruby2.0 ruby2.0-dev).each do |name|
        package name
      end

      %w(ruby erb gem irb rake rdoc ri testrb).each do |cmd|
        execute "update-alternatives-install-#{cmd}2.0" do
          action :run
          command "update-alternatives --install /usr/bin/#{cmd} #{cmd} /usr/bin/#{cmd}2.0 100"
          not_if "update-alternatives --list #{cmd} | grep /usr/bin/#{cmd}2.0"
        end
      end
    else
      log "ruby_install_type 'auto' could not find a ruby for this ubuntu version"
    end
  else
    log "ruby_install_type 'auto' could not find a ruby for this platform"
  end
else
  log "ruby will not be installed by lita cookbook"
end

# this should be cached by the root user and vagrant seems to screw this up
ENV['HOME'] = '/root'
gem_package "bundler"
