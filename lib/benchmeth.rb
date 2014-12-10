require "benchmeth/version"
require "active_support/notifications"

# :( Global
$benchmeth_main = self

module Benchmeth
  DEFAULT_BLOCK = lambda do |method, realtime|
    puts "%s : %d ms" % [method, realtime * 1000]
  end

  def self.on_benchmark(&block)
    if block_given?
      @on_benchmark_block = block
    else
      @on_benchmark_block || DEFAULT_BLOCK
    end
  end

  module ClassMethods

    def benchmark(*method_names)
      method_names.each do |method_name|
        method_name = method_name.to_sym
        self.send :alias_method, :"#{method_name}_without_benchmark", method_name
        self.send :define_method, method_name do |*args, &block|
          method_prefix =
            case self
            when $benchmeth_main
              ""
            when Class
              "#{self.name}."
            else
              "#{self.class.name}#"
            end

          payload = {
            name: "#{method_prefix}#{method_name}",
            args: args
          }
          ActiveSupport::Notifications.instrument "benchmark.benchmeth", payload do
            self.send(:"#{method_name}_without_benchmark", *args, &block)
          end
        end
      end
    end

  end

  module InstanceMethods

    def benchmark(*method_names, &block)
      self.class.benchmark(*method_names, &block)
    end

  end

end

Object.extend Benchmeth::ClassMethods
Object.send :include, Benchmeth::InstanceMethods
