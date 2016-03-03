v1.0.5 (2016-03-03)
-------------------
- [#30] - @desktophero added service options as attributes and updated the tests

v1.0.4 (2015-12-20)
-------------------
- [#27] - @MattMencel finalized RHEL/Centos 7 support
- [#26] - @ngtjah reported a derived attributes issue and fix added
- [#25] - @ngtjah added initial RHEL/Centos 7 support and fixed the rubygem source typo/bug
- [#9] - finally got around to backgrounding in init script

v1.0.3 (2015-11-19)
-------------------
- [#23] - @desktophero added an attribute to set the gem source
- [#24] - @shortdudey123 added an attribute for config.robot.alias

v1.0.2 (2015-11-04)
-------------------
- [#22] - @notnmeyer consolidated init recipes and added daemon group control

v1.0.1 (2015-04-14)
-------------------
- [#21] - @ptqa added improvements to runit init system configuration

v1.0.0 (2015-03-26)
-------------------
- [#20] and [#8] - @ptqa added support for multiple init systems; added runit; runit is now default. NOTE: given this is a breaking change, I decided to go 1.0.0.

v0.1.5 (2015-02-11)
-------------------
- Updated README with missing attributes

v0.1.4 (2015-02-11)
-------------------
- [#18] - Allow overriding of Gemfile and init templates
- [#19] - Add Rake tasks for style checks

v0.1.3 (2015-01-18)
-------------------
- Gemfile changes cause a failure due to file ownership.

v0.1.2 (2015-01-18)
-------------------
- [#16] - no more VERSION file
- [#12] and [#15] - Lita v4 deprecates struct style access of config.redis

v0.1.1 (2014-12-19)
-------------------
- [#13] - typo in README.md
- [#14] - make test kitchen work with serverspec ver > 2

v0.1.0 (2014-12-02)
-------------------
- [#10] - Breaking change.  Supports new config.adapters for Lita v4+.  Older versions of Lita will likely not work anymore.
- Changed these attribute names and class types to make them plural.  ["lita"]["adapters"] and ["lita"]["adapter_versions"]

v0.0.4 (2014-09-29)
-------------------
- [#3] - Runs bundler as the daemon user but also does some backflips to try to ensure a little degree of security
- [#5] - Using su instead of sudo and writes out console output to daemon.log
- [#6] - Full embracing of the hack to try to and rubyify strings and/or normal ruby attributes into the ruby config
- Added the exit code in the init script but I don't think it helps alot. I think most failures happen after lita has backgrounded itself.

v0.0.3 (2014-08-12)
-------------------
- Added the rest of the standard Lita attributes (mention name and http properties) (issue #2)
- Added new "gems" attribute to add in custom gem setups. This allowed me to remove the pagerduty-sdk logic in the Gemfile.erb
- Turned the package installation into an attribute so native packages can be added as needed by adapter or handlers
- Fixed single/double quote stuff in the recipe. I'm not very consistent with that stuff

v0.0.2 (2014-07-23)
-------------------
- Initial version
