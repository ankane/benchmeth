require "benchmeth/version"
require "benchmark"

module Benchmeth

  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def benchmeth(*method_names, &block)
      method_names.each do |method_name|
        method_name = method_name.to_sym
        self.send :alias_method, :"#{method_name}_without_benchmark", method_name
        self.send :define_method, method_name do |*args|
          result = nil
          realtime = Benchmark.realtime { result = self.send(:"#{method_name}_without_benchmark", *args) }
          block.call(method_name, realtime)
          result
        end
      end
    end

  end

  module InstanceMethods

    def benchmeth(*method_names, &block)
      self.class.benchmeth(*method_names, &block)
    end

  end

end

Object.send :include, Benchmeth
