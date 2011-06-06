# encoding: utf-8

require 'spec_helper'

describe Algebra::Join, '#join_header' do
  subject { object.join_header }

  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])                         }
  let(:right)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }
  let(:object) { described_class.new(left, right)                                             }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ] ] }
end
