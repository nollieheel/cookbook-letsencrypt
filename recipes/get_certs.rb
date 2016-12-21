#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: cookbook-letsencrypt
# Recipe:: get_certs
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

directory node[cb]['config_dir'] do
  recursive true
end

comm = "#{node[cb]['source_dir']}/letsencrypt-auto certonly"
if node[cb]['test'] then comm << ' --test-cert' end

node[cb]['configs'].each do |conf|
  if conf[:domains].is_a?(Array) && conf[:domains].length > 0

    name = conf[:domains][0]

    template "#{node[cb]['config_dir']}/config_#{name}.ini" do
      source 'config.ini.erb'
      mode   0444
      variables(
        :rsa_key_size  => conf[:rsa_key_size] || '4096',
        :authenticator => conf[:authenticator] || 'standalone',
        :email         => conf[:email] || "''",
        :domains       => conf[:domains],
      )
    end

    execute "get_cert_#{name}" do
      command "#{comm} --config #{node[cb]['config_dir']}/config_#{name}.ini"
      only_if { node[cb]['obtain_certs'] }
      not_if  { Dir.exist?("#{node[cb]['install_dir']}/archive/#{name}") }
    end

  end
end
