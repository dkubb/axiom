# encoding: utf-8

require 'spec_helper'

describe Algebra::Extension, '#header' do
  subject { object.header }

  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { described_class.new(operand, extensions)             }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Relation::Header) }

  it { should == [ [ :id, Integer ], [ :test, Object ] ] }
end
