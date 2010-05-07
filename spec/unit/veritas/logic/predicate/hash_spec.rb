require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#hash' do
  subject { predicate.hash }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

  it { should be_kind_of(Integer) }

  it { should == attribute.hash ^ 1.hash }
end
