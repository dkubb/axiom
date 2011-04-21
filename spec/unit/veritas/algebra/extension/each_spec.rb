require 'spec_helper'

describe Algebra::Extension, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { described_class.new(operand, extensions)             }
  let(:yields)     { []                                                   }

  it_should_behave_like 'an #each method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1, 1 ], [ 2, 1 ] ])
  end
end
