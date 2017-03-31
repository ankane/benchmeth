require "benchmeth/version"

# :( Global
$benchmeth_main = self

module Benchmeth
  class << self
    attr_accessor :use_notifications
  end
  self.use_notifications = false

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
        send :alias_method, :"#{method_name}_without_benchmark", method_name
        send :define_method, method_name do |*args, &block|
          method_prefix =
            case self
            when $benchmeth_main
              ""
            when Class
              "#{name}."
            else
              "#{self.class.name}#"
            end

          if Benchmeth.use_notifications
            payload = {
              name: "#{method_prefix}#{method_name}"
            }
            ActiveSupport::Notifications.instrument "benchmark.benchmeth", payload do
              send(:"#{method_name}_without_benchmark", *args, &block)
            end
          else
            start_time = Time.now
            result = send(:"#{method_name}_without_benchmark", *args, &block)
            realtime = Time.now - start_time
            Benchmeth.on_benchmark.call("#{method_prefix}#{method_name}", realtime)
            result
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
