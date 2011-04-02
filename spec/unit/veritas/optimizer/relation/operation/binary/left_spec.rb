require 'spec_helper'

describe Optimizer::Relation::Operation::Binary, '#left' do
  subject { object.left }

  let(:klass)     { Optimizer::Relation::Operation::Binary           }
  let(:optimized) { mock('Optimized')                                }
  let(:left)      { mock('Left', :optimize => optimized)             }
  let(:right)     { mock('Right')                                    }
  let(:relation)  { mock('Relation', :left => left, :right => right) }
  let(:object)    { klass.new(relation)                              }

  before do
    right.stub!(:optimize).and_return(right)
  end

  it { should equal(optimized) }
end
