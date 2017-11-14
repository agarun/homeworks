require 'rspec'
require 'dessert'

describe Dessert do
  subject(:tiramisu) { Dessert.new("custard", 10, "batali") }
  let(:chef) { double("chef") }

  describe "#initialize" do
    it "sets a type" do
      expect(tiramisu.type).to eq("custard")
    end

    it "sets a quantity" do
      expect(tiramisu.quantity).to_not be_falsy
    end

    it "starts ingredients as an empty array" do
      expect(tiramisu.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("", "test", "") }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      tiramisu.add_ingredient("sugar")
      expect(tiramisu.ingredients).to include("sugar")
    end
  end

  describe "#mix!" do
    let(:pre_shuffle) { double(tiramisu.ingredients) }

    it "shuffles the ingredient array" do
      tiramisu.mix!
      expect(tiramisu.ingredients).to_not eq(:pre_shuffle)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      tiramisu.eat(1)
      expect(tiramisu.quantity).to eq(9)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { tiramisu.eat(11) }.to raise_error
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(tiramisu.serve).to include("Batali")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(tiramisu)
      chef.bake(tiramisu)
    end
  end
end
