require_relative "test_helper"

class TestBenchmeth < Minitest::Test
  def test_instance_method
    car = Car.new
    car.boom(60)
  end

  def test_class_method
    Car.boom2
  end

  def test_active_support_instance_method
    use_notifications do
      Car.new.boom(60)
    end
  end

  def test_active_support_class_method
    use_notifications do
      Car.boom2
    end
  end

  private

  def use_notifications
    Benchmeth.stub(:use_notifications, true) do
      yield
    end
  end
end
