# cookbook-letsencrypt-cookbook

Installs LetsEncrypt certificates using Certbot as described [here](https://certbot.eff.org/docs/install.html). For more information on how to use the certbot client, see [here](https://certbot.eff.org/docs/using.html).

Also installs a bash script that attempts to auto-renew the certificates every specified number of days.

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
    <td>Array of hashes detailing the certificates needed, whether it's for testing or production, and if to actually try and obtain those certificates. An example hash is: `{ :email => 'admin@mydomain.com', :domains => ['mydomain.com'] }`.</td>
    <td><tt>[]</tt></td>
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
    <td><tt>['cookbook-letsencrypt']['renew']['pre_hook']</tt></td>
    <td>String</td>
    <td>Shell command to run pre-renewal. Ex: "'service nginx restart'" (Note quotes).</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['post_hook']</tt></td>
    <td>String</td>
    <td>Shell command to run post-renewal.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['cookbook-letsencrypt']['renew']['fail_hook']</tt></td>
    <td>String</td>
    <td>Shell command to run in the event a renewal is attempted but has failed for whatever reason.</td>
    <td><tt>(See attributes file)</tt></td>
  </tr>
</table>

## Usage

### cookbook-letsencrypt::default

Populate the attributes necessary for your node. Different Certbot plugins might be appropriate depending on when this cookbook is run on the Chef client runlist. For example, if Nginx is installed first, `cookbook-letsencrypt` can then be run with the `nginx` plugin.

```ruby
default['cookbook-letsencrypt']['configs'] = [ {
  :domains => ['mysite.com', 'www.mysite.com'],
  :email => 'webmaster@mysite.com',
  :authenticator => 'nginx',
  :test => false
} ]
```

Include `cookbook-letsencrypt` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[cookbook-letsencrypt]"
  ]
}
```

## License and Authors

Author:: Earth U (<iskitingbords @ gmail.com>)
