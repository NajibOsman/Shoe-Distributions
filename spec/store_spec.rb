require 'spec_helper'

describe(Store) do
  # spec for adding anew brand to a store
  describe('#brand') do
    it "adds a brand to a store" do
      test_store = Store.create({:name => 'Portland Store'})
      test_brand = Brand.create({:name => 'Awesome Possum'})
      test_store.brands.push(test_brand)
      expect(test_store.brands).to(eq([test_brand]))
    end
  end

  #Spec for  validating the name
  describe('#store') do
    it "disallows blank name with validation" do
      test_store = Store.new({:name => ""})
      expect(test_store.save).to(eq(false))
    end
  end
  #the spec for capitalizing the first letter of name
  describe('#capitalize_name') do
    it "capitalizes inputted name" do
      test_store = Store.create({:name => "nike outlet"})
      expect(test_store.name).to(eq('Nike outlet'))
    end
  end
  #It disallows same brand to be added again
  describe('#uniqueness') do
    it "disallows creation of the same Brand name more than once" do
      test_brand = Brand.create({:name => "Nike"})
      test_brand2 = Brand.new({:name => "Nike"})
      expect(test_brand2.save).to(eq(false))
    end
  end
  #Disallows adding abrand twice
  describe('#brand_unique_per_store') do
    it "disallows adding same brand twice to the same store" do
      test_store = Store.create({:name => "Store"})
      test_brand = Brand.create({:name => "Brand"})
      test_store.brands.push(test_brand)
      expect(test_store.brand_unique_per_store(test_brand)).to(eq(false))
    end
  end

end
