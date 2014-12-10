require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"

class Car

  def start(speed)
    sleep(1)
  end
  benchmark :start

  def boom(speed)
    sleep(1)
  end
  benchmark :boom #, payload: -> (speed) { speed * 10000000 }

  def self.boom2
    sleep(1)
  end
  class << self
    benchmark :boom2
  end

end

ActiveSupport::Notifications.subscribe do |name, started, finished, unique_id, data|
  puts "%s : %d ms" % [data[:name], (finished - started) * 1000]
end
