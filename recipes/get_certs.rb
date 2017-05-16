#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: cookbook-letsencrypt
# Recipe:: get_certs
#
# Copyright 2017, Earth U
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

comm0 = "#{node[cb]['source_dir']}/letsencrypt-auto certonly"

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

    get_cert = conf.has_key?(:get_cert) ? conf[:get_cert] : true
    test     = conf.has_key?(:test) ? conf[:test] : true
    comm1    = test ? ' --test-cert' : ''

    archive_dir = "#{node[cb]['install_dir']}/archive/#{name}"
    unless Dir.exist?(archive_dir)
      execute "get_cert_#{name}" do
        command "#{comm0}#{comm1} --config "\
                "#{node[cb]['config_dir']}/config_#{name}.ini"
        only_if { get_cert }
      end
    else
      log "Letsencrypt archive dir exists: #{archive_dir}. Skipping get_cert."
    end

  end
end
