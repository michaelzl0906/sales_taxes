# frozen_string_literal: true

require_relative '../../models/product'

RSpec.describe Product, '#total_price' do
  context 'with sales tax' do
    it 'calculates the total price with tax' do
      product = Product.new(quantity: 1,
                            product_name: 'test product',
                            price: 14.99)

      expect(product.total_price).to eq 16.49
    end

    it 'calculates the total price of imported product with tax' do
      product = Product.new(quantity: 1,
                            product_name: 'test imported product',
                            price: 47.50)

      expect(product.total_price).to eq 54.65
    end

    it 'calculates the total price of exempted product with tax' do
      product = Product.new(quantity: 1,
                            product_name: 'test book product',
                            price: 12.49)

      expect(product.total_price).to eq 12.49
    end

    it 'calculates the total price of exempted and imported product with tax' do
      product = Product.new(quantity: 1,
                            product_name: 'test imported book product',
                            price: 11.25)

      expect(product.total_price).to eq 11.85
    end
  end
end

RSpec.describe Product, '#imported?' do
  context 'with domestic / imported goods' do
    it 'returns false for the domestic goods' do
      product = Product.new(quantity: 1,
                            product_name: 'test product',
                            price: 14.99)

      expect(product.imported?).to be_falsey
    end

    it 'returns true for the imported goods' do
      product = Product.new(quantity: 1,
                            product_name: 'test imported product',
                            price: 14.99)

      expect(product.imported?).to be_truthy
    end
  end
end
