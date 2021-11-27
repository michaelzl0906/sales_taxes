# frozen_string_literal: true

require_relative '../../models/product'

RSpec.describe Product do
  let(:product) do
    Product.new(quantity: 1,
                product_name: 'test product',
                price: 14.99)
  end

  let(:product_imported) do
    Product.new(quantity: 1,
                product_name: 'test imported product',
                price: 47.50)
  end

  let(:product_exempted) do
    Product.new(quantity: 1,
                product_name: 'test book product',
                price: 12.49)
  end

  let(:product_exempted_imported) do
    Product.new(quantity: 1,
                product_name: 'test imported chocolates',
                price: 11.25)
  end

  describe '#total_price' do
    it 'calculates the total price with tax' do
      expect(product.total_price).to eq 16.49
    end

    it 'calculates the total price of imported product with tax' do
      expect(product_imported.total_price).to eq 54.65
    end

    it 'calculates the total price of exempted product with tax' do
      expect(product_exempted.total_price).to eq 12.49
    end

    it 'calculates the total price of exempted and imported product with tax' do
      expect(product_exempted_imported.total_price).to eq 11.85
    end
  end

  describe '#imported?' do
    it 'returns false for the domestic goods' do
      expect(product.imported?).to be_falsey
    end

    it 'returns true for the imported goods' do
      expect(product_imported.imported?).to be_truthy
    end
  end
end
