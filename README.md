# cookbook-letsencrypt-cookbook

Installs using the Let's Encrypt Client as described [here](https://letsencrypt.readthedocs.io/en/latest/intro.html "Let's Encrypt Client Documentation"). Currently supports only the `standalone` plugin. So just simple stuff.

Also installs a script that attempts to auto-renew the certificates every specified number of days.

## Supported Platforms

Currently tested on Ubuntu 14.04.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['configs']</tt></td>
    <td>Array</td>
    <td>Array of hashes detailing the certificates needed. An example hash is: `{ :email => 'admin@mydomain.com', :domains => ['mydomain.com'] }`.</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['obtain_certs']</tt></td>
    <td>Boolean</td>
    <td>Whether or not to actually try and obtain the certificates (i.e., run 'letsencrypt-auto certonly').</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['test']</tt></td>
    <td>Boolean</td>
    <td>Set to true during testing, false on live servers.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['repo_url']</tt></td>
    <td>String</td>
    <td>URL of Lets Encrypt source.</td>
    <td><tt>'https://github.com/letsencrypt/letsencrypt.git'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['source_dir']</tt></td>
    <td>String</td>
    <td>Directory location of `letsencrypt-auto` binary.</td>
    <td><tt>'/opt/letsencrypt/letsencrypt'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['config_dir']</tt></td>
    <td>String</td>
    <td>Where to put the generated config files for LE certs.</td>
    <td><tt>'/opt/letsencrypt/config'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['script_dir']</tt></td>
    <td>String</td>
    <td>Where to put the auto-renew script.</td>
    <td><tt>'/opt/letsencrypt/priv'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['webserver_service']</tt></td>
    <td>String</td>
    <td>Name of the currently running webserver service on the node. The auto-renew script needs to `service stop` it during every renewal attempt.</td>
    <td><tt>'nginx'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['days']</tt></td>
    <td>Integer</td>
    <td>Number of days before each auto-renewal attempt.</td>
    <td><tt>15</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['time']</tt></td>
    <td>String</td>
    <td>Time of day when the renewal is attempted. Can be in the format: `12am`. Timezone is dependent on the server.</td>
    <td><tt>'8am'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['fail_email']</tt></td>
    <td>String/Boolean</td>
    <td>If the auto-renewal attempt fails, an email alert can be sent to this address. Set to boolean `false` to disable this behavior.</td>
    <td><tt>'your@email.com'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['fail_subject']</tt></td>
    <td>String</td>
    <td>The subject of the alert email.</td>
    <td><tt>'LetsEncrypt Cert Renewal Failure Alert'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['success_actions']</tt></td>
    <td>Array</td>
    <td>Bash commands to perform immediately once the Letsencrypt "renew" call is successful.</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['sendmail_bin']</tt></td>
    <td>String</td>
    <td>Enter here the location of the sendmail binary.</td>
    <td><tt>'/usr/sbin/sendmail'</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['log_path']</tt></td>
    <td>String</td>
    <td>Enter here the location of the Lets Encrypt log file.</td>
    <td><tt>'/var/log/letsencrypt/letsencrypt.log'</tt></td>
  </tr>
</table>

## Usage

### cookbook-letsencrypt::default

Include `cookbook-letsencrypt` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[cookbook-letsencrypt::default]"
  ]
}
```

## License and Authors

Author:: Earth U (<iskitingbords @ gmail.com>)
