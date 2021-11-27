# frozen_string_literal: true

require 'fileutils'
require_relative './models/product'
require_relative './models/basket'

if ARGV.empty?
  p 'Please include the input file path.'
  exit
else
  input_file_path = ARGV[0]

  unless File.file? input_file_path
    p 'Please provide a valid file path.'
    exit
  end

  input_data = CSV.read(input_file_path)
  # remove headers
  input_data.shift

  shopping_basket = Basket.new
  input_data.each do |row|
    quantity, product_name, price = row.map(&:strip)
    shopping_basket << Product.new(quantity: quantity.to_i,
                                   product_name: product_name,
                                   price: price.to_f)
  end

  # write to file
  output_dir = 'outputs'
  FileUtils.mkdir(output_dir) unless Dir.exist? output_dir
  File.write("#{output_dir}/output_#{File.basename(input_file_path)}.csv", shopping_basket.receipt)
end
