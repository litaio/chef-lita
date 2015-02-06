require 'rubocop/rake_task'
require 'foodcritic'

namespace :style do
  desc 'Run rubocop linting'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ['--lint']
    task.fail_on_error = true
  end

  desc 'Run foodcritic linting'
  FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
    t.options = {
      fail_tags: ['any'],
    }
  end
end

desc 'Run all style checks'
task style: ['style:rubocop', 'style:foodcritic']
