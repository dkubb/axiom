require 'spec_helper'

describe 'Veritas::Algebra::Extension#extensions' do
  subject { object.extensions }

  let(:klass)      { Algebra::Extension                                   }
  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { klass.new(operand, extensions)                       }

  it { should equal(extensions) }

  it_should_behave_like 'an idempotent method'
end
