#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: cookbook-letsencrypt
# Recipe:: get_certs
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

directory node[cookbook_name]['config_dir'] { recursive true }

node[cookbook_name]['configs'].each do |conf|
  if conf[:domains].is_a?(Array) && conf[:domains].length > 0

    name = conf[:domains][0]
    config = "#{node[cookbook_name]['config_dir']}/#{name}.ini"

    template config do
      source    'config.ini.erb'
      mode      0444
      variables conf
    end

    comm = "#{node[cookbook_name]['bin']} "\
           "#{conf.has_key?(:command) ? conf[:command] : 'certonly' } "\
           "--noninteractive"
    test = conf.has_key?(:test) ? conf[:test] : true
    comm << ( test ? ' --test-cert' : '' )

    get_cert = conf.has_key?(:get_cert) ? conf[:get_cert] : true
    execute "get_cert_#{name}" do
      command "#{comm} --config #{config}"
      only_if { get_cert }
    end

  end
end
