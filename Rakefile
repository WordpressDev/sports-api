require 'rake/testtask'

desc 'Run dev server'
task :server do
  sh 'rackup -p 9000 config.ru'
end

desc 'Run tests'
Rake::TestTask.new do |t|
  t.libs <<  '.'
  t.test_files = FileList['test.rb']
  t.verbose = true
end
