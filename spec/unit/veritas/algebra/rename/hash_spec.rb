require 'spec_helper'

describe Algebra::Rename, '#hash' do
  subject { object.hash }

  let(:operand) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])  }
  let(:aliases) { described_class::Aliases.new(:id => :other_id) }
  let(:object)  { described_class.new(operand, aliases)          }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash ^ aliases.hash }
end
