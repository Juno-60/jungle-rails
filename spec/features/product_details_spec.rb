require 'rails_helper'

RSpec.feature "visitor clicks on an individual product", type: :feature, js: true do

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

  scenario "they click on product and are redirected to its page" do
    
    # ACT
    visit root_path

    find('.product header', match: :first).click

    # click_link(['product'])

    # page.find('product').click

    # DEBUG / VERIFY
    # save_screenshot

    # expectation:
    expect(page).to have_css 'section.products-show'
  end

end