require 'spec_helper'

describe 'lita::default' do

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.automatic['platform']         = 'ubuntu'
      node.automatic['platform_version'] = '12.04'
      node.automatic['platform_family']  = 'debian'
      node.automatic['lsb']['codename']  = 'precise'
      node.automatic['memory']['total']  = 2048
      node.set['lita']['packages']   = ['openssl']
    end.converge(described_recipe)
  end

  it 'includes the default recipe from the apt cookbook' do
    expect(chef_run).to include_recipe('apt::default')
  end

  it 'includes the default recipe from the build-essential cookbook' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  it 'installs packages in the lita packages attribute' do
    expect(chef_run).to install_package('openssl')
  end

  it 'includes the ruby recipe from the lita cookbook' do
    expect(chef_run).to include_recipe('lita::ruby')
  end

  it 'includes the ruby recipe from the lita cookbook' do
    expect(chef_run).to include_recipe('lita::redis')
  end

  it 'creates the lita directory' do
    expect(chef_run).to create_directory('/opt/lita')
  end

  it 'creates the lita log directory' do
    expect(chef_run).to create_directory('/opt/lita/logs').with(
      user:  'nobody',
      group: 'nobody'
    )
  end

  it 'creates the lita run directory' do
    expect(chef_run).to create_directory('/opt/lita/run').with(
      user:  'nobody',
      group: 'nobody'
    )
  end

  it 'installs the Gemfile template' do
    expect(chef_run).to create_template('/opt/lita/Gemfile')
  end

  it 'installs the lita_config.rb template' do
    expect(chef_run).to create_template('/opt/lita/lita_config.rb')
  end

  it 'executes the file Gemfile.lock to be deleted' do
    expect(chef_run).not_to delete_file('Gemfile.lock')
  end

  it 'executes the ruby bundler command on the Gemfile' do
    expect(chef_run).not_to run_execute('bundle-install-lita')
  end

  it 'executes the recurseive chown of bin and vendor install dir' do
    expect(chef_run).not_to run_execute('chown-bundle')
  end

  it 'installs the lita init.d template' do
    expect(chef_run).to create_template('/etc/init.d/lita')
  end

  it 'enabled and starts the lita service' do
    expect(chef_run).to enable_service('lita')
    expect(chef_run).to start_service('lita')
  end

end
