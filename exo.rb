class ItemUpdater
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def days(number_of_days)
    number_of_days
  end

  def update_item
    update_quality
    advance_one_day
  end

  def update_quality
    decrease_quality
    normalize_quality
  end

  def advance_one_day
    item.sell_in -= days(1)
  end

  def decrease_quality
    item.quality -= quality_decrease_amount
  end

  def quality_decrease_amount
    item.sell_in > days(0) ? 1 : 2
  end

  def normalize_quality
    item.quality = [[item.quality, 0].max, 50].min
  end
end

class LegendaryItemUpdater < ItemUpdater
  def update_item
  end
end

class ConjuredItemUpdater < ItemUpdater
  def quality_decrease_amount
    2 * super
  end
end

class BackstagePassUpdater < ItemUpdater
  def quality_decrease_amount
    return item.quality if item.sell_in <= days(0)
    return -3 if item.sell_in <= days(5)
    return -2 if item.sell_in <= days(10)
    -1
  end
end

class CheeseUpdater < ItemUpdater
  def quality_decrease_amount
    item.sell_in > days(0) ? -1 : -2
  end
end

class ItemUpdaterFactory
  ITEM_CLASSES = {
    'Sulfuras, Hand of Ragnaros' => LegendaryItemUpdater,
    'Conjured Mana Cake' => ConjuredItemUpdater,
    'Aged Brie' => CheeseUpdater,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassUpdater,
  }.freeze

  def self.updater_for_item(item)
    klass = ITEM_CLASSES[item.name] || ItemUpdater
    klass.new(item)
  end
end

def update_quality(items)
  items.each do |item|
    updater = ItemUpdaterFactory.updater_for_item(item)
    updater.update_item
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
