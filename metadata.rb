name             'lita'
maintainer       'Harlan Barnes'
maintainer_email 'hbarnes@pobox.com'
license          'Apache 2.0'
description      'Installs/configures the lita chatbot'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

supports 'ubuntu'

depends 'apt'
depends 'build-essential'
depends 'ruby-ng', '~> 0.1.1'
depends 'redis2', '~> 0.5.0'