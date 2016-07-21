#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: cookbook-letsencrypt
# Recipe:: auto_renew_script
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

package 'at'

directory node[cb]['renew']['script_dir'] do
  recursive true
end

template "#{node[cb]['renew']['script_dir']}/auto_renew" do
  action   :create
  notifies :run, 'execute[schedule_auto_renew]'
  variables(
    :days          => node[cb]['renew']['days'],
    :time          => node[cb]['renew']['time'],
    :script_dir    => node[cb]['renew']['script_dir'],
    :web_service   => node[cb]['renew']['webserver_service'],
    :source_dir    => node[cb]['source_dir'],
    :email_subject => node[cb]['renew']['fail_subject'],
    :email_to      => node[cb]['renew']['fail_email'],
    :s_actions     => node[cb]['renew']['success_actions'],
    :sendmail_bin  => node[cb]['sendmail_bin'],
    :log_path      => node[cb]['log_path']
  )
end

execute 'schedule_auto_renew' do
  command "bash #{node[cb]['renew']['script_dir']}/auto_renew -s"
  action  :nothing
end
