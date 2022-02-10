require 'rails_helper'

RSpec.feature "visitor adds product to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "visitor clicks add button and change is reflected in navbar cart item count" do
    
    # ACT
    visit root_path
    find('.product footer', match: :first).click_on('Add')
    # DEBUG / VERIFY
    # save_screenshot

    # expectation:
    expect(page).to have_content('My Cart (1)')
  end

end