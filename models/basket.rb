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
end
