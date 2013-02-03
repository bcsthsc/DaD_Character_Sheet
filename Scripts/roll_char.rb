#! /usr/bin/ruby

# Roll for Character Attributes

srand(Time.new.to_i)  unless ARGV.empty?

def roll()
  (1..4).to_a.collect {|dummy| rand(6) + 1}.sort {|a,b| b <=> a}[0,3].inject(0) {|sum,arg| sum + arg}
end

Array.new(6).collect {|dummy| roll()}.sort {|a,b| b <=> a}.each {|arg| printf($stdout, "%2d\n", arg)}
