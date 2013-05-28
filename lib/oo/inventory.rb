module Oo
  module Inventory
    AXE = :AXE
    SHOVEL = :SHOVEL
    ROPE = :ROPE
    MATCHES = :MATCHES
    SCROLL = :SCROLL
    COINS = :COINS
    VACUUM = :VACUUM
    BATTERIES = :BATTERIES
    STATUE = :STATUE
    KEY = :KEY
    MAGIC_SPELLS = :MAGIC_SPELLS
    RING = :RING
    CANDLESTICK = :CANDLESTICK
    CANDLE = :CANDLE
    PAINTING = :PAINTING
    BOAT = :BOAT
    GOBLET = :GOBLET
    AEROSOL = :AEROSOL

    attr_accessor :objects

    def initialize
      @all_objects = {}
      Inventory.constants(false).each do |obj|
        begin
          @all_objects[obj] = Object.const_get(to_class(obj)).new
        rescue
          # Ignore
        end
      end
      @objects = {}
    end

    def thing(object)
      @all_objects[to_up_sym(object)]
    end

    def valid?(object)
      @all_objects.include?(to_up_sym(object))
    end

    def carrying?(object)
      @objects.keys.include?(to_up_sym(object))
    end

    def carry(object)
      object = to_up_sym(object)
      @objects[object] = @all_objects[object]
    end

    def leave(object)
      object = to_up_sym(object)
      @objects.delete(object) if carrying?(object)
    end

    def time
      message = ""
      @objects.each_value do |object|
        message += object.time
      end
      message
    end

    def to_up_sym(object)
      object.to_s.upcase.gsub(/ /, '_').to_sym
    end

    private

    def to_class(object)
      object.to_s.split('_').map { |s| s.capitalize }.join
    end
  end
end
