#!/usr/bin/env ruby

require 'zeitwerk'

foo_bar_path = File.expand_path('lib/foo/bar.rb', __dir__)

loader = Zeitwerk::Loader.new
loader.push_dir(File.expand_path('lib', __dir__))
loader.enable_reloading
loader.setup

File.write(foo_bar_path, <<~RUBY)
class Foo::Bar
	def zzz
	end
end
RUBY

bar1 = Foo::Bar.new
pp bar1: bar1

File.write(foo_bar_path, <<~RUBY)
class Foo::Bar
	def yyy
	end
end
RUBY

loader.reload

bar2 = Foo::Bar.new

pp bar1: bar1, bar2: bar2
binding.irb
