require 'spec_helper'

describe 'lita::redis' do

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.automatic['platform']         = 'ubuntu'
      node.automatic['platform_version'] = '12.04'
      node.automatic['platform_family']  = 'debian'
      node.automatic['lsb']['codename']  = 'precise'
      node.automatic['memory']['total']  = 2048
    end.converge(described_recipe)
  end

  it 'includes the default recipe from the redis2 cookbook' do
    expect(chef_run).to include_recipe('redis2::default')
  end

end
