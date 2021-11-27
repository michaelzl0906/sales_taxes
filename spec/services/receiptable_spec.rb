# frozen_string_literal: true

require_relative '../../models/basket'

RSpec.describe Receiptable do
  describe '#receipt' do
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

    it 'generates the correct csv string' do
      shopping_basket = Basket.new
      shopping_basket << product
      shopping_basket << product_imported
      shopping_basket << product_exempted
      shopping_basket << product_exempted_imported

      expect(shopping_basket.receipt)
        .to eq "1,test product,16.49\n" \
                "1,test imported product,54.65\n" \
                "1,test book product,12.49\n" \
                "1,test imported chocolates,11.85\n\n" \
                "Sales Taxes: 9.25\n" \
                "Total: 95.48\n"
    end
  end
end
