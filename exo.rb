def bs_quality_appreciation(item)
  return -item.quality if item.sell_in <= 0
  return 3 if item.sell_in <= 5
  return 2 if item.sell_in <= 10
  return 1
end

def base_quality_appreciation(item)
  return bs_quality_appreciation(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
  return 2 if item.name == 'Aged Brie' && item.sell_in <= 0
  return 1 if item.name == 'Aged Brie'
  return -2 if item.sell_in <= 0

  item.quality.zero? ? 0 : -1
end

def quality_appreciation(item)
  amount = base_quality_appreciation(item)
  amount *= 2 if item.name == 'Conjured Mana Cake' && amount < 0

  amount
end

def update_quality(items)
  items.each do |item|
    next if item.name == 'Sulfuras, Hand of Ragnaros'

    quality_amount = item.quality + quality_appreciation(item)
    item.quality = [[quality_amount, 0].max, 50].min
    item.sell_in -= 1
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
