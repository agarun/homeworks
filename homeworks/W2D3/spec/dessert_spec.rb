require 'rspec'
require 'dessert'

describe Dessert do
  let(:chef) { double("chef", name: "Bourdain") }
  let(:tiramisu) { Dessert.new("custard", 10, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(tiramisu.type).to eq("custard")
    end

    it "sets a quantity" do
      expect(tiramisu.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(tiramisu.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("", "test", chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      tiramisu.add_ingredient("sugar")
      expect(tiramisu.ingredients).to include("sugar")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["sugar", "eggs", "cocoa", "butter", "kisses"]
      ingredients.each { |ingredient| tiramisu.add_ingredient(ingredient) }
      
      tiramisu.mix!
      expect(tiramisu.ingredients).to_not eq(ingredients)
      expect(tiramisu.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      tiramisu.eat(2)
      expect(tiramisu.quantity).to eq(8)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { tiramisu.eat(11) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Bourdain the Great Baker")
      expect(tiramisu.serve).to eq("Chef Bourdain the Great Baker has made 10 custards!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake).with(tiramisu)
      tiramisu.make_more
    end
  end
end
