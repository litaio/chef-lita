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
