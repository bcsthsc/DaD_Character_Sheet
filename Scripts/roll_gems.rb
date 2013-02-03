#! /usr/bin/ruby

# Roll for Gems
# c.f. Dungeon Master's Guide, p. 55


# extract random array element
class Array
  def random
    self.empty? ? nil : self.at(rand(self.size))
  end
end


# this function yields the dice-roll nDd
def roll(n, d)
  return 0  unless n.kind_of?(Integer)
  return 0  unless d.kind_of?(Integer)
  return 0  if n <= 0
  return 0  if d <= 0

  (1..n).inject(0) {|sum,dummyvar| sum + (rand(d) + 1)}
end


# this function evaluates table 3-6 on page 55 of the Dungeon Master's Guide
def eval_gem()
  r = roll(1,100)
  if    ( 1..25).include?(r) then [       roll(4,4), ["banded agate", "eye agate", "moss agate", "azurite", "blue quartz", "hematite", "lapis lazuli",
                                                      "malachite", "obsidian", "rhodochrosite", "tiger eye turquiose", "freshwater pearl"].random]
  elsif (26..50).include?(r) then [  10 * roll(2,4), ["bloodstone", "carnelian", "chalcedony", "chrysoprase", "citrine", "iolite", "jasper", "moonstone",
                                                      "onyx", "peridot", "rock crystal", "sard", "sardonyx", "rose quartz", "smoky quartz", "star rose quartz", "zircon"].random]
  elsif (51..70).include?(r) then [  10 * roll(4,4), ["amber", "amethyst", "chrysoberyl", "coral", "red garnet", "brown-green garnet", "jade", "jet",
                                                      "white pearl", "golden pearl", "pink pearl", "silver pearl", "red spinel", "red-brown spinel", "deep green spinel", "tourmaline"].random]
  elsif (71..90).include?(r) then [ 100 * roll(2,4), ["alexandrite", "aquamarine", "violet garnet", "black pearl", "deep blue spinel", "golden yellow topaz"].random]
  elsif (91..99).include?(r) then [ 100 * roll(4,4), ["emerald", "white opal", "black opal", "fire opal", "blue sapphire", "fiery yellow corundum", "rich purple corundum",
                                                      "blue star sapphire", "black star sapphire", "star ruby"].random]
  elsif r == 100             then [1000 * roll(2,4), ["clearest bright green emerald", "blue-white diamond", "canary diamond", "pink diamond", "brown diamond", "blue diamond", "jacinth"].random]
  end
end



list = Array.new
ARGV.each do
  |arg|
  next  unless arg =~ /^\d+$/
  arg = arg.to_i
  next  if arg <= 0

  1.upto(arg).each {|dummyvar| list.push(eval_gem())}
end
list.sort! {|a,b| a.first <=> b.first}
list.each {|a| printf($stdout, "%4d GP  %s\n", a.first, a.last)}
