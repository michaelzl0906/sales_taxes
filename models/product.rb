# frozen_string_literal: true

require_relative '../services/taxable'

# Product model
class Product
  include Taxable

  attr_reader :quantity, :product_name, :price

  def initialize(quantity:, product_name:, price:)
    @quantity = quantity
    @product_name = product_name
    @price = price
  end

  def total_price
    @total_price ||= (@price + tax).round(2)
  end

  def imported?
    # The product name contains "imported" considered imported goods
    @imported ||= @product_name.split(' ').include? 'imported'
  end
end
