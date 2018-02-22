#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: cookbook-letsencrypt
# Attribute:: default
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

default['cookbook-letsencrypt']['configs'] = [
  #{
    # Certbot subcommand that should be used when obtaining a certificate.
    # Can be: run, certonly
    # Default: certonly
    #:command => 'certonly',

    # Certbot installer to use. Can be: apache, nginx, nil.
    # Default: nil (Do not use plugin)
    #:installer => nil,

    # Authenticator can be: apache, webroot, nginx, standalone, manual
    # Default is: standalone
    #:authenticator => 'standalone',

    #:rsa_key_size => '2048', # default: '2048'
    #:email        => String, # mandatory
    #:domains      => [],     # mandatory

    #:test     => true, # default: true # Whether testing or not
    #:get_cert => true  # default: true # Try to obtain certs during recipe run

    #:command_options => '' # Additional options to certbot-auto if desired
  #}
]

default['cookbook-letsencrypt']['bin']        = '/usr/bin/certbot-auto'
default['cookbook-letsencrypt']['config_dir'] = '/opt/letsencrypt/config'
default['cookbook-letsencrypt']['binary_url'] = 'https://dl.eff.org/certbot-auto'

# For auto-renew script:

# In example below, certbot will try to renew every 15 days at 8am.
default['cookbook-letsencrypt']['renew']['days'] = 15
default['cookbook-letsencrypt']['renew']['time'] = '8am' # server timezone

default['cookbook-letsencrypt']['renew']['script_dir'] = '/opt/letsencrypt/priv'
# For pre-, post-, and fail- hooks, string values will be included
# on the command line 'as is', so do not forget to add quotes for
# non-trivial commands. e.g. "'service nginx restart'".
default['cookbook-letsencrypt']['renew']['pre_hook']  = nil
default['cookbook-letsencrypt']['renew']['post_hook'] = nil
# Hook that runs if renewal was attempted but failed:
default['cookbook-letsencrypt']['renew']['fail_hook'] =
<<-EOT
        echo "Error detected. Emailing my@email.com now."
        errlog=$( tail /var/log/letsencrypt/letsencrypt.log )
        echo -e "Subject: LetsEncrypt Cert Renewal Failure Alert\\nTo: my@email.com\\n\\n${errlog}" | /usr/sbin/sendmail -t
EOT
