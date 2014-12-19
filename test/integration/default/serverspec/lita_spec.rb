require 'serverspec'

set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = '/bin:/usr/bin:/sbin:/usr/sbin'
  end
end

describe "Lita Chat Bot Installation and Configuration" do

  case os[:family]
  when "Ubuntu"
    it "should have a file called /usr/local/bin/redis-server" do
      expect(file("/usr/local/bin/redis-server")).to be_file
    end
    case os[:release]
    when "12.04"
      it "should be install ruby 2.1" do
        expect(package("ruby2.1")).to be_installed
      end
      it "should be install ruby 2.1 dev" do
        expect(package("ruby2.1-dev")).to be_installed
      end
    when "14.04"
      it "should be install ruby 2.0" do
        expect(package("ruby2.0")).to be_installed
      end
      it "should be install ruby 2.0 dev" do
        expect(package("ruby2.0-dev")).to be_installed
      end
    end
  end

  it "should be listening on 6379 on localhost" do
    expect(port(6379)).to be_listening
  end

  it "should have a main directory" do
    expect(file("/opt/lita")).to be_directory
  end

  it "should have a log directory" do
    expect(file("/opt/lita/logs")).to be_directory
  end

  it "should have a run directory" do
    expect(file("/opt/lita/run")).to be_directory
  end

  it "should have a config file" do
    expect(file("/opt/lita/lita_config.rb")).to be_file
  end

  # TODO: needs an adapter that can be daemonized
  # it "should have the lita daemon running" do
  #   expect(service("lita")).to be_running
  # end

end
