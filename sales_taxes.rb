# frozen_string_literal: true

require 'csv'
require 'fileutils'
require_relative './models/product'

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

  # write to csv
  total_tax = 0
  total_price = 0
  csv_string = CSV.generate do |csv|
    input_data.each do |row|
      quantity, product_name, price = row.map(&:strip)
      product = Product.new(quantity: quantity.to_i,
                            product_name: product_name,
                            price: price.to_f)

      csv << [product.quantity, product.product_name, format('%.2f', product.total_price)]

      total_tax += product.tax
      total_price += product.total_price
    end

    # empty row
    csv << []
    csv << [format('Sales Taxes: %.2f', total_tax)]
    csv << [format('Total: %.2f', total_price)]
  end

  output_dir = 'outputs'
  FileUtils.mkdir(output_dir) unless Dir.exist? output_dir

  File.write("#{output_dir}/output_#{File.basename(input_file_path)}.csv", csv_string)
end
