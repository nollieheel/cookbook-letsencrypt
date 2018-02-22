#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: cookbook-letsencrypt
# Recipe:: auto_renew_script
#
# Copyright 2018, Earth U
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

package 'at'

directory node[cookbook_name]['renew']['script_dir'] { recursive true }

template "#{node[cookbook_name]['renew']['script_dir']}/auto_renew.sh" do
  action   :create
  notifies :run, 'execute[schedule_auto_renew]'
  variables(
    :days        => node[cookbook_name]['renew']['days'],
    :time        => node[cookbook_name]['renew']['time'],
    :certbot_bin => node[cookbook_name]['bin'],
    :script_dir  => node[cookbook_name]['renew']['script_dir'],
    :pre_hook    => node[cookbook_name]['renew']['pre_hook'],
    :post_hook   => node[cookbook_name]['renew']['post_hook'],
    :fail_hook   => node[cookbook_name]['renew']['fail_hook']
  )
end

execute 'schedule_auto_renew' do
  command "bash #{node[cookbook_name]['renew']['script_dir']}/auto_renew.sh -s"
  action  :nothing
end
