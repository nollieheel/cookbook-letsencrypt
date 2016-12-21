#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: cookbook-letsencrypt
# Attribute:: default
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

cb = 'cookbook-letsencrypt'

default[cb]['configs'] = [
  #{
    #:rsa_key_size  => '4096',            # default: '4096'
    #:email         => 'admin@email.com', # default: ''
    #:domains       => ['example.com'],   # default: []
    ## No other authenticator plugins are supported yet by this cookbook
    #:authenticator => 'standalone'       # default: 'standalone'
  #}
]
default[cb]['obtain_certs'] = true
default[cb]['test']         = true # whether we are testing or not
default[cb]['repo_url']     = 'https://github.com/letsencrypt/letsencrypt.git'
default[cb]['source_dir'] = '/opt/letsencrypt/letsencrypt'
default[cb]['config_dir'] = '/opt/letsencrypt/config'

# For auto-renew script:

default[cb]['renew']['script_dir']        = '/opt/letsencrypt/priv'
default[cb]['renew']['webserver_service'] = 'nginx'

# In example below, LE will try to renew every 15 days at 8am.
default[cb]['renew']['days'] = 15
default[cb]['renew']['time'] = '8am' # Timezone depends on server.

# If renewal fails, send an alert email.
# Set 'fail_email' to false to disable this behavior.
default[cb]['renew']['fail_email']   = 'your@email.here'
default[cb]['renew']['fail_subject'] = 'LetsEncrypt Cert Renewal Failure Alert'

default[cb]['renew']['success_actions'] = []

# Constants:

default[cb]['sendmail_bin'] = '/usr/sbin/sendmail'
default[cb]['log_path']     = '/var/log/letsencrypt/letsencrypt.log'
default[cb]['install_dir']  = '/etc/letsencrypt'
