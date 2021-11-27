# frozen_string_literal: true

# Calculate sales taxes for products
module Taxable
  BASIC_TAXES_RATE = 0.1
  IMPORT_DUTY_RATE = 0.05

  # NOTE: I don't think this is a good solution to categorize the products,
  # but it appears we can only identify the product type by name.
  # I could add more items to the list, but we can never include everything in real world.
  # These lists are created based on the sample inputs.
  BOOKS = %w[book].freeze
  FOOD = %w[chocolate chocolates].freeze
  MEDICAL_PRODUCTS = %w[pills].freeze
  EXEMPTION_LIST = BOOKS + FOOD + MEDICAL_PRODUCTS

  # @return [String]
  def product_name
    raise NotImplementedError
  end

  # @return [Float]
  def price
    raise NotImplementedError
  end

  # @return [Boolean]
  def imported?
    raise NotImplementedError
  end

  # @return [Float]
  def tax
    tax_rate = if exempted?
                 0
               else
                 BASIC_TAXES_RATE
               end

    tax_rate += IMPORT_DUTY_RATE if imported?

    # rounded up to the nearest 0.05
    @tax ||= (price * tax_rate * 20).ceil / 20.0
  end

  private

  # @return [Boolean]
  def exempted?
    product_name.split(' ').each do |name|
      return true if EXEMPTION_LIST.include?(name)
    end

    false
  end
end
