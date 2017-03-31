require_relative "test_helper"

class TestBenchmeth < Minitest::Test
  def test_instance_method
    car = Car.new
    car.boom(60)
  end

  def test_class_method
    Car.boom2
  end
end
