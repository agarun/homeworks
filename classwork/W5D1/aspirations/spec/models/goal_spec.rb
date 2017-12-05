require 'rails_helper'

RSpec.describe Goal, type: :model do
  subject(:valid_goal) { FactoryBot.build(:goal) }

  describe "validates attributes" do
    it { should validate_presence_of :goal}
  end

  describe "associations" do
    it { should belong_to :user }
  end

  describe "defaults" do
    it "is public by default" do
      expect(valid_goal.private).to be_falsy
    end

    it "is incomplete by default" do
      expect(valid_goal.completed).to be_falsy
    end
  end
end
