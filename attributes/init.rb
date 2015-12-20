default['lita']['runit']['finish'] = false

# Note that this is available for overriding in wrappers or roles/environments.
# However by default, it will be set to:
#
# {
#   'HOME' => node['lita']['install_dir'],
#   'PATH' => [node['languages']['ruby']['bin_dir'],
#              node['languages']['ruby']['gem_bin'],
#              node['languages']['ruby']['ruby_dir']
#              ].join(':')
# }
#
# This is to avoid the derived attributes problem:
#   https://christinemdraper.wordpress.com/2014/10/06/avoiding-the-possible-pitfalls-of-derived-attributes/
#
default['lita']['runit']['env'] = nil

default['lita']['init_style'] = 'runit'
