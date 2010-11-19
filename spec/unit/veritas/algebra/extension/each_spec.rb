require 'spec_helper'

describe 'Veritas::Algebra::Extension#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)      { Algebra::Extension                                   }
  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { klass.new(operand, extensions)                       }
  let(:yields)     { []                                                   }

  it_should_behave_like 'a command method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1, 1 ], [ 2, 1 ] ])
  end
end
