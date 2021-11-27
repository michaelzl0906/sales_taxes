# frozen_string_literal: true

require 'csv'
require_relative '../models/product'

# Generate receipt for products
module Receiptable
  # @return [Array<Product>]
  def products
    raise NotImplementedError
  end

  # @return [Numeric]
  def total_tax
    raise NotImplementedError
  end

  # @return [Numeric]
  def total_price
    raise NotImplementedError
  end

  # Generate receipt in CSV format
  # @return [String]
  def receipt
    CSV.generate do |csv|
      products.each do |product|
        csv << [product.quantity, product.product_name, to_currency(product.total_price)]
      end

      # empty row
      csv << []
      csv << ["Sales Taxes: #{to_currency(total_tax)}"]
      csv << ["Total: #{to_currency(total_price)}"]
    end
  end

  private

  # @param number [Numeric]
  # @return [String]
  def to_currency(number)
    format '%.2f', number
  end
end
