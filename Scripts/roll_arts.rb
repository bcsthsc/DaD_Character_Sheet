#! /usr/bin/ruby

# Roll for Art Objects
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


# this function evaluates table 3-7 on page 55 of the Dungeon Master's Guide
def eval_art()
  r = roll(1,100)
  if    ( 1..10).include?(r) then [  10 * roll(1,10), ["silver ewer", "carved bone statuette", "ivory statuette", "finely wrought small gold bracelet"].random]
  elsif (11..25).include?(r) then [  10 * roll(3, 6), ["cloth of gold vestments", "black velvet mask with numerous citrines", "silver chalice with lapis lazuli gems"].random]
  elsif (26..40).include?(r) then [ 100 * roll(1, 6), ["large well-done wool tapestry", "brass mug with jade inlays"].random]
  elsif (41..50).include?(r) then [ 100 * roll(1,10), ["silver comb with moon stones", "silver-plated steel longsword with jet jewel in hilt"].random]
  elsif (51..60).include?(r) then [ 100 * roll(2, 6), ["carved harp of exotic wood with ivory inlay and zircon gems", "solid gold idol"].random]
  elsif (61..70).include?(r) then [ 100 * roll(3, 6), ["gold dragon comb with red garnet eye", "gold and topaz bottle stopper cork", "ceremonial electrum dagger with a star ruby in the pommel"].random]
  elsif (71..80).include?(r) then [ 100 * roll(4, 6), ["eyepatch with mock eye of sapphire and moonstone", "fire opal pendant on a fine gold chain", "old masterpiece painting"].random]
  elsif (81..85).include?(r) then [ 100 * roll(5, 6), ["embroidered silk and velvet mantle with numerous moonstones", "sapphire pendant on gold chain"].random]
  elsif (86..90).include?(r) then [1000 * roll(1, 4), ["embroidered and bejeweled glove", "jeweled anklet", "gold music box"].random]
  elsif (91..95).include?(r) then [1000 * roll(1, 6), ["golden circlet with four aquamarines", "string of small pink pearls (necklace)"].random]
  elsif (96..99).include?(r) then [1000 * roll(2, 4), ["jeweled gold crown", "jeweled electrum ring"].random]
  elsif r == 100             then [1000 * roll(2, 6), ["gold and ruby ring", "gold cup set with emeralds"].random]
  end
end



list = Array.new
ARGV.each do
  |arg|
  next  unless arg =~ /^\d+$/
  arg = arg.to_i
  next  if arg <= 0

  1.upto(arg).each {|dummyvar| list.push(eval_art())}
end
list.sort! {|a,b| a.first <=> b.first}
list.each {|a| printf($stdout, "%4d GP  %s\n", a.first, a.last)}
