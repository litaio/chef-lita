require 'spec_helper'

describe 'lita::init_service' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.automatic['platform']         = 'ubuntu'
      node.automatic['platform_version'] = '12.04'
      node.automatic['platform_family']  = 'debian'
      node.automatic['lsb']['codename']  = 'precise'
      node.automatic['memory']['total']  = 2048
      node.set['lita']['packages']   = ['openssl']
      node.set['lita']['init_style'] = 'init'
      node.set['lita']['service'] = [:enable, :start]
    end.converge(described_recipe)
  end

  it 'installs the lita init.d template' do
    expect(chef_run).to create_template('/etc/init.d/lita')
  end

  context 'service options are true' do
    it 'enabled and starts the lita service' do
      expect(chef_run).to enable_service('lita')
      expect(chef_run).to start_service('lita')
    end
  end

  context 'service options are :enable only' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.automatic['platform']         = 'ubuntu'
        node.automatic['platform_version'] = '12.04'
        node.automatic['platform_family']  = 'debian'
        node.automatic['lsb']['codename']  = 'precise'
        node.automatic['memory']['total']  = 2048
        node.set['lita']['packages']   = ['openssl']
        node.set['lita']['init_style'] = 'init'
        node.set['lita']['service'] = [:enable]
      end.converge(described_recipe)
    end

    it 'enabled and starts the lita service' do
      expect(chef_run).to enable_service('lita')
      expect(chef_run).to_not start_service('lita')
    end
  end

  context 'service options are :start only' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.automatic['platform']         = 'ubuntu'
        node.automatic['platform_version'] = '12.04'
        node.automatic['platform_family']  = 'debian'
        node.automatic['lsb']['codename']  = 'precise'
        node.automatic['memory']['total']  = 2048
        node.set['lita']['packages']   = ['openssl']
        node.set['lita']['init_style'] = 'init'
        node.set['lita']['service'] = [:start]
      end.converge(described_recipe)
    end

    it 'enabled and starts the lita service' do
      expect(chef_run).to_not enable_service('lita')
      expect(chef_run).to start_service('lita')
    end
  end

  context 'service options are :nothing only' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.automatic['platform']         = 'ubuntu'
        node.automatic['platform_version'] = '12.04'
        node.automatic['platform_family']  = 'debian'
        node.automatic['lsb']['codename']  = 'precise'
        node.automatic['memory']['total']  = 2048
        node.set['lita']['packages']   = ['openssl']
        node.set['lita']['init_style'] = 'init'
        node.set['lita']['service'] = [:nothing]
      end.converge(described_recipe)
    end

    it 'enabled and starts the lita service' do
      expect(chef_run).to_not enable_service('lita')
      expect(chef_run).to_not start_service('lita')
    end
  end
end
