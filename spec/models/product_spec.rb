require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Checks for Validations' do
    it 'confirms that a Product with all required fields set will save succesfully' do
      @category = Category.create(id: 69, name: "Furniture")
      @product = Product.create(name: "test", price: 420, quantity: 1, category_id: @category.id)
      expect(@product).to be_valid
    end
    it 'returns an error if name is invalid' do
      @category = Category.create(id: 69, name: "Furniture")
      @product = Product.create(name: nil, price: 320, quantity: 2, category_id: @category.id)
      expect(@product.name).to eql(nil)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'returns errors if price is invalid' do
      @category = Category.create(id: 69, name: "Furniture")
      @product = Product.create(name: "Beef", price: nil, quantity: 2, category_id: @category.id)
      expect(@product.price).to eql(nil)
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'returns an error if quantity is invalid' do
      @category = Category.create(id: 69, name: "Furniture")
      @product = Product.create(name: "Beef", price: 640, quantity: nil, category_id: @category.id)
      expect(@product.quantity).to eql(nil)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'returns an error if category is invalid' do
      @category = Category.create(id: 69, name: "Furniture")
      @product = Product.create(name: "Beef", price: 640, quantity: 2, category_id: nil)
      expect(@product.category).to eql(nil)
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
