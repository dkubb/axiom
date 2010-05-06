require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#hash' do
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }

  subject { negation.hash }

  it { should be_kind_of(Integer) }

  it { should == operand.hash }
end
