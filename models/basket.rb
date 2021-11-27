# frozen_string_literal: true

require_relative '../services/receiptable'

# Shopping basket
class Basket
  include Receiptable

  # @return [Array<Product>]
  attr_reader :products

  def initialize
    @products = []
  end

  # @param product [Product]
  def <<(product)
    @products << product
  end

  # @return [Numeric]
  def total_tax
    @total_tax ||= @products.sum(&:tax)
  end

  # @return [Numeric]
  def total_price
    @total_price ||= @products.sum(&:total_price)
  end
end
