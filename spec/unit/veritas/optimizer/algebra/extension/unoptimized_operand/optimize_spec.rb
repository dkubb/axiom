require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Extension::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Algebra::Extension::UnoptimizedOperand }
  let(:header)     { Relation::Header.new([ [ :id, Integer ] ])        }
  let(:base)       { Relation.new(header, [ [ 1 ] ].each)              }
  let(:extensions) { [ :text, lambda { |tuple| 1 } ]                   }
  let(:operand)    { base.project(header)                              }
  let(:relation)   { operand.extend { |r| r.add(*extensions) }         }
  let(:object)     { klass.new(relation)                               }

  before do
    object.operation.should be_kind_of(Algebra::Extension)
  end

  it { should_not equal(operand) }

  it { should eql(base.extend { |r| r.add(*extensions) }) }

  its(:extensions) { should == Hash[ [extensions] ] }
end
