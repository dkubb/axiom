require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Binary#right' do
  subject { object.right }

  let(:klass)     { Optimizer::Relation::Operation::Binary           }
  let(:optimized) { mock('Optimized')                                }
  let(:left)      { mock('Left')                                     }
  let(:right)     { mock('Right', :optimize => optimized)            }
  let(:relation)  { mock('Relation', :left => left, :right => right) }
  let(:object)    { klass.new(relation)                              }

  before do
    left.stub!(:optimize).and_return(left)
  end

  it { should equal(optimized) }
end
