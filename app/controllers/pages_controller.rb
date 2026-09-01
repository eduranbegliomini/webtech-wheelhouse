class PagesController < ApplicationController
  def home
  end

  def services
    @jobs = [
      { name: "Flat Tire Fix", price: 15 },
      { name: "Brake Adjustment", price: 20 },
      { name: "Gear Tuning", price: 25 },
      { name: "Basic Tune-up", price: 60 },
      { name: "Full Overhaul", price: 150 },
      { name: "Chain Replacement", price: 30 },
      { name: "Wheel Truing", price: 40 },
      { name: "Suspension Service", price: 120 },
      { name: "Custom Bike Build", price: 250 },
      { name: "Handlebar Wrapping", price: 25 },
      { name: "Pedal Installation", price: 10 },
      { name: "Safety Inspection", price: 35 }
    ]
  end

  def visiting
  end

  def about
  end
end