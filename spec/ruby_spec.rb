require 'spec_helper'

describe 'lita::ruby' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.automatic['platform']         = 'ubuntu'
      node.automatic['platform_version'] = '12.04'
      node.automatic['platform_family']  = 'debian'
      node.automatic['lsb']['codename']  = 'precise'
      node.automatic['memory']['total']  = 2048
    end.converge(described_recipe)
  end

  it 'includes the default recipe from the ruby-ng cookbook' do
    expect(chef_run).to include_recipe('ruby-ng::default')
  end

  it 'installs the package for ruby2.1-dev' do
    expect(chef_run).to install_package('ruby2.1-dev')
  end

  it 'installs the Gem for bundler' do
    expect(chef_run).to install_gem_package('bundler')
  end
end
