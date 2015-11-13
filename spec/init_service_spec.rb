require 'spec_helper'

describe 'lita::init_service' do

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.automatic['platform']         = 'ubuntu'
      node.automatic['platform_version'] = '12.04'
      node.automatic['platform_family']  = 'debian'
      node.automatic['lsb']['codename']  = 'precise'
      node.automatic['memory']['total']  = 2048
      node.set['lita']['packages']   = ['openssl']
      node.set['lita']['init_style'] = 'init'
    end.converge(described_recipe)
  end

  it 'installs the lita init.d template' do
    expect(chef_run).to create_template('/etc/init.d/lita')
  end

  it 'enabled and starts the lita service' do
    expect(chef_run).to enable_service('lita')
    expect(chef_run).to start_service('lita')
  end

end
