module DI
  def self.configure(&blk)
    instance_eval &blk
  end
  
  def self.mappings
    @mappings ||= {}
  end
  
  module ConstructorMethods
    def constructor(*args)
      @constructor_args = args
      define_method :initialize do
        args.each do |key|
          mapped_injections = DI.mappings[self.class.name.to_sym].call
          instance_variable_set "@#{key}", mapped_injections[key]
        end
      end
    end
  end

  def self.construct(key, &blk)
    DI.mappings[key] = blk
  end

  load File.dirname(__FILE__) + "/../config/di.rb"
end

Class.send :include, DI::ConstructorMethods
