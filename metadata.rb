name             'cookbook-letsencrypt'
maintainer       'Earth U'
maintainer_email 'iskitingbords @ gmail.com'
license          'Apache License'
description      'Installs/Configures cookbook-phpmyadmin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/nollieheel/cookbook-letsencrypt'
issues_url       'https://github.com/nollieheel/cookbook-letsencrypt/issues'
version          '0.1.1'

depends 'git', '~> 4.4.1'
depends 'apt', '~> 2.9.2'

supports 'ubuntu', '>= 14.04'
