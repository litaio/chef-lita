default['lita']['runit']['finish'] = false
default['lita']['runit']['env'] = {
  'HOME' => node['lita']['install_dir'],
  'PATH' => [node['languages']['ruby']['bin_dir'],
             node['languages']['ruby']['gem_bin'],
             node['languages']['ruby']['ruby_dir']
             ].join(':')
}
default['lita']['init_style'] = 'runit'
