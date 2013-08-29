class ObjectBuilder
  def initialize(object)
    @object = object
  end

  def respond_to_missing?(missing_method, include_private=false)
    missing_method =~ /=\z/
  end

  def method_missing(missing_method, *args, &block)
    if respond_to_missing?(missing_method)
      method_name = missing_method.to_s.sub(/=\z/, '')
      value = args.first
      ivar_name = "@#{method_name}"
      if value.is_a?(Proc)
        define_code_method(method_name, ivar_name, value)
      else
        define_value_method(method_name, ivar_name, value)
      end
    else
      super
    end
  end

  def define_value_method(method_name, ivar_name, value)
    @object.instance_variable_set(ivar_name, value)
    @object.define_singleton_method(method_name) do
      instance_variable_get(ivar_name)
    end
  end

  def define_code_method(method_name, ivar_name, implementation)
    @object.instance_variable_set(ivar_name, implementation)
    @object.define_singleton_method(method_name) do |*args|
      instance_exec(*args, &instance_variable_get(ivar_name))
    end
  end

  def prototype(proto)
    # Leave method implementations on the proto object
    ivars = proto.instance_variables.reject { |ivar_name|
      proto.respond_to?(ivar_name.to_s[1..-1]) &&
        proto.instance_variable_get(ivar_name).is_a?(Proc)
    }
    ivars.each do |ivar_name|
      unless @object.instance_variable_defined?(ivar_name)
        @object.instance_variable_set(
          ivar_name,
          proto.instance_variable_get(ivar_name).dup)
      end
    end
    @object.extend(Prototype.new(proto))
  end
end

class Prototype < Module
  def initialize(target)
    @target = target
    super() do
      define_method(:respond_to_missing?) do |missing_method, include_private|
        target.respond_to?(missing_method)
      end

      define_method(:method_missing) do |missing_method, *args, &block|
        if target.respond_to?(missing_method)
          implementation = target.implementation_of(missing_method)
          instance_exec(*args, &implementation)
        else
          super(missing_method, *args, &block)
        end
      end
    end
  end
end

class Object
  def copy
    prototype = clone

    instance_variables.each do |ivar_name|
      prototype.instance_variable_set(
        ivar_name,
        instance_variable_get(ivar_name).clone)
    end

    prototype
  end

  def implementation_of(method_name)
    if respond_to?(method_name)
      implementation = instance_variable_get("@#{method_name}")
      if implementation.is_a?(Proc)
        implementation
      elsif instance_variable_defined?("@#{method_name}")
        # Assume the method is a reader
        -> { instance_variable_get("@#{method_name}") }
      else
        method(method_name).to_proc
      end
    end
  end
end

def Object(object=nil, &definition)
  obj = object || Object.new
  obj.singleton_class.instance_exec(ObjectBuilder.new(obj), &definition)
  obj
end

adventurer = Object
room = Object { |o|
  o.exits = {}
}
container = Object { |o|
  o.items = []
  o.transfer_item = ->(item, recipient) {
    recipient.items << items.delete(item)
  }
}

path = Object { |o|
  o.description = <<END
Path through an Iron Gate
END
}
front_porch = Object { |o|
  o.description = <<END
Front Porch
END
}
twisted_railing = Object { |o|
  o.description = <<END
By a Twisted Railing
END
}
railings = Object { |o|
  o.description = <<END
By Railings
END
}
beneath_front_tower = Object { |o|
  o.description = <<END
Beneath the Front Tower
END
}
debris = Object { |o|
  o.description = <<END
Debris from Crumbling Facade
END
}

Object(path) { |o|
  o.prototype room
  o.prototype container
  o.exits = {
    north: front_porch,
    west: twisted_railing,
    east: railings
  }
}

Object(railings) { |o|
  o.prototype room
  o.prototype container
  o.exits = {
    east: beneath_front_tower
  }
}

Object(beneath_front_tower) { |o|
  o.prototype room
  o.prototype container
  o.exits = {
    east: debris
  }
}

Object(debris) { |o|
  o.prototype room
  o.prototype container
  o.items = ["AEROSOL"]
}

Object(adventurer) { |o|
  o.location = path
  attr_writer :location

  o.look = ->(*args) {
    puts location.description
  }
  o.prototype container

  o.go = ->(direction) {
    if (destination = location.exits[direction])
      self.location = destination
      puts location.description
    else
      puts "You can't go that way"
    end
  }

  o.look = -> {
    puts location.description
    location.items.each do |item|
      puts "There is #{item} here."
    end
  }

  o.take = ->(item_name) {
    item = location.items.detect { |item| item.include?(item_name) }
    if item
      location.transfer_item(item, self)
      puts "You take #{item}."
    else
      puts "You see no #{item_name} here"
    end
  }

  o.get = ->(item_name) {
    take(item_name)
  }

  o.drop = ->(item_name) {
    item = items.detect { |item| item.include?(item_name) }
    if item
      transfer_item(item, location)
      puts "You drop #{item}."
    else
      puts "You are not carrying #{item_name}"
    end
  }

  o.inventory = -> {
    items.each do |item|
      puts "You have #{item}"
    end
  }
}

adventurer.location = path
adventurer.look
adventurer.go(:east)
adventurer.go(:east)
adventurer.go(:east)
adventurer.take("AEROSOL")
adventurer.drop("AEROSOL")
adventurer.get("AEROSOL")
adventurer.look