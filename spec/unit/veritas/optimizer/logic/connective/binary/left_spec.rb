require 'spec_helper'

describe Optimizer::Logic::Connective::Binary, '#left' do
  subject { object.left }

  let(:klass)           { Optimizer::Logic::Connective::Binary               }
  let(:optimized_left)  { mock('Optimized Left')                             }
  let(:optimized_right) { mock('Optimized Right')                            }
  let(:left)            { mock('Left',  :optimize => optimized_left)         }
  let(:right)           { mock('Right', :optimize => optimized_right)        }
  let(:connective)      { mock('Connective', :left => left, :right => right) }
  let(:object)          { klass.new(connective)                              }

  it { should equal(optimized_left) }
end
