## 0.2.1 - 2016-12-21
### Added
- Add an attribute that controls whether or not certificates are obtained from LE api.
- Add some echo feedback to auto-renew script, in case it is run manually.

### Changed
- recipes/get_certs.rb: If certs are to be obtained, make sure an attempt is made regardless of whether the LE config template is update/created or not.

# 0.2.0

Allow option to run some bash commands right after renewal

# 0.1.2

Add distribution attribute to apt_repository resource

# 0.1.1

Remove -v flag from sendmail call

# 0.1.0

Initial release of cookbook-letsencrypt
