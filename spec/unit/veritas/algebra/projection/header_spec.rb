require 'spec_helper'

describe Algebra::Projection, '#header' do
  subject { object.header }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object)   { described_class.new(relation, [ :id ])        }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ] ] }
end
