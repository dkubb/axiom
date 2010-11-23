require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Combination#header' do
  subject { object.header }

  let(:klass)  { CombinationOperationSpecs::Object                        }
  let(:left)   { Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])   }
  let(:right)  { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }
  let(:object) { klass.new(left, right)                                   }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Relation::Header) }

  it 'unions the headers' do
    should == [ [ :id, Integer ], [ :name, String ] ]
  end
end
