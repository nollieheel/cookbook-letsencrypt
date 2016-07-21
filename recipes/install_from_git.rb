#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: cookbook-letsencrypt
# Recipe:: install_from_git
#
# Copyright 2016, Earth U
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

cb = cookbook_name

apt_repository 'git' do
  uri          'ppa:git-core/ppa'
  distribution node['lsb']['codename']
end

include_recipe 'git'

directory ::File.dirname(node[cb]['source_dir']) do
  recursive true
end

git node[cb]['source_dir'] do
  repository node[cb]['repo_url']
  action     :sync
  notifies   :run, 'execute[init_le_auto]', :immediately
end

execute 'init_le_auto' do
  command "#{node[cb]['source_dir']}/letsencrypt-auto --help"
  action  :nothing
end
