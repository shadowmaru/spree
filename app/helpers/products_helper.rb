module ProductsHelper
  # returns the price of the product to show for display purposes
  def product_price(product_or_variant, options={})
    options.assert_valid_keys(:format_as_currency)
    options.reverse_merge! :format_as_currency => true
    
    amount = product_or_variant.is_a?(Product) ? product_or_variant.master_price : product_or_variant.price

    options[:format_as_currency] ? format_price(amount, options) : amount
  end
  
  # returns the formatted change in price (from the master price) for the specified variant (or simply return 
  # the variant price if no master price was supplied)
  def variant_price_diff(variant)
    return product_price(variant) unless variant.product.master_price
    diff = product_price(variant, :format_as_currency => false) - product_price(variant.product, :format_as_currency => false)
    return nil if diff == 0
    if diff > 0
      "(#{t("Add")}: #{format_price diff.abs})"
    else
      "(#{t("Subtract")}: #{format_price diff.abs})"
    end
  end
  
  def format_price(price)
    number_to_currency(price)
  end
  
  # converts line breaks in product description into <p> tags (for html display purposes)
  def product_description(product)
    product.description.gsub(/^(.*)$/, '<p>\1</p>')
  end  
  
end
