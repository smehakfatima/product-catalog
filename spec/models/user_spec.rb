require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Associations' do
    it 'has_many products' do
      association = described_class.reflect_on_association(:products)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end
end