require 'spec_helper'

describe Algebra::Restriction, '#hash' do
  subject { object.hash }

  let(:klass)     { Algebra::Restriction                          }
  let(:operand)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:predicate) { proc { true }                                 }
  let(:object)    { klass.new(operand, predicate)                 }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ operand.hash ^ predicate.hash }
end
