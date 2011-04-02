require 'spec_helper'

describe Optimizer::Relation::Operation::Binary, '#right' do
  subject { object.right }

  let(:optimized) { mock('Optimized')                                }
  let(:left)      { mock('Left')                                     }
  let(:right)     { mock('Right', :optimize => optimized)            }
  let(:relation)  { mock('Relation', :left => left, :right => right) }
  let(:object)    { described_class.new(relation)                    }

  before do
    left.stub!(:optimize).and_return(left)
  end

  it { should equal(optimized) }
end
