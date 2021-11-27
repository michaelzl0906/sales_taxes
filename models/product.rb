# frozen_string_literal: true

require_relative '../services/taxable'

# Product model
class Product
  include Taxable

  # @return [Integer]
  attr_reader :quantity

  # @return [String]
  attr_reader :product_name

  # @return [Float]
  attr_reader :price

  # @param quantity [Integer]
  # @param product_name [String]
  # @param price [Float]
  def initialize(quantity:, product_name:, price:)
    @quantity = quantity
    @product_name = product_name
    @price = price
  end

  # @return [Integer, Float]
  def total_price
    @total_price ||= (@price + tax).round(2)
  end

  # @return [Integer, nil]
  def imported?
    # The product name contains "imported" considered imported goods
    @product_name =~ /imported/
  end
end
