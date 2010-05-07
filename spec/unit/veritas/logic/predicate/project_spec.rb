require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#project' do
  let(:attribute)  { Attribute::Integer.new(:id)       }
  let(:other)      { Attribute::Integer.new(:other_id) }
  let(:attributes) { [ attribute ]                     }

  subject { predicate.project(attributes) }

  context 'when left is an attribute' do
    context 'and it is not removed' do
      let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

      it 'returns self' do
        should equal(predicate)
      end
    end

    context 'and it is removed' do
      let(:predicate) { PredicateSpecs::Object.new(other, 1) }

      it 'returns nil' do
        should be_nil
      end
    end
  end

  context 'when right is an attribute' do
    context 'and it is not removed' do
      let(:predicate) { PredicateSpecs::Object.new(1, attribute) }

      it 'returns self' do
        should equal(predicate)
      end
    end

    context 'and it is removed' do
      let(:predicate) { PredicateSpecs::Object.new(1, other) }

      it 'returns nil' do
        should be_nil
      end
    end
  end

  context 'when neither left or right is a removed attribute' do
    let(:predicate) { PredicateSpecs::Object.new(1, 1) }

    it 'returns self' do
      should equal(predicate)
    end
  end
end
