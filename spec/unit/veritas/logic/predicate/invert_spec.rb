require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#invert' do
  subject { predicate.invert }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

  it 'negates the predicate' do
    should eql(Logic::Connective::Negation.new(predicate))
  end

  it 'inverts back to original' do
    subject.invert.should equal(predicate)
  end
end
