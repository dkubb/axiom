require 'spec_helper'

describe Algebra::Restriction, '#hash' do
  subject { object.hash }

  let(:operand)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:predicate) { proc { true }                                 }
  let(:object)    { described_class.new(operand, predicate)       }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash ^ predicate.hash }
end
