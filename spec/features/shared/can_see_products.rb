RSpec.shared_examples "can see products in the page" do
  scenario "User can see the products" do
    expect(page).to have_css('body .product-card', count: products.size)
    products.each do |product|
      expect(page).to have_xpath("//body//*[contains(@class, 'product-card')]//a/img[contains(@alt, \"#{product.name}\")]")
      expect(page).to have_xpath("//body//*[contains(@class, 'product-card')]//p[contains(text(), \"#{product.description[0, 50]}\")]")
      expect(page).to have_xpath("//body//*[contains(@class, 'product-card')]//a[text()=\"#{product.name}\"]")
      expect(page).to have_xpath("//body//*[contains(@class, 'product-card')]//*[contains(text(), \"U$ #{product.price}\")]")
    end
  end
end