# frozen_string_literal: true

require_relative '../../services/taxable'

RSpec.describe Taxable, '#tax' do
  context 'with product' do
    it 'calculates the sales tax for domestic product' do
      product = Product.new(quantity: 1,
                            product_name: 'test product',
                            price: 14.99)

      expect(product.tax).to eq 1.5
    end

    it 'calculates the sales tax for imported product' do
      product = Product.new(quantity: 1,
                            product_name: 'test imported product',
                            price: 47.50)

      expect(product.tax).to eq 7.15
    end

    it 'calculates the sales tax for exempted product' do
      product = Product.new(quantity: 1,
                            product_name: 'test book product',
                            price: 12.49)

      expect(product.tax).to eq 0
    end

    it 'calculates the sales tax for exempted and imported product' do
      product = Product.new(quantity: 1,
                            product_name: 'test imported chocolates',
                            price: 11.25)

      expect(product.tax).to eq 0.6
    end
  end
end
