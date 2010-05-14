require 'spec_helper'

describe 'Veritas::Attribute#call' do
  subject { attribute.call(tuple) }

  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:header)    { Relation::Header.new([ attribute ]) }
  let(:tuple)     { Tuple.new(header, [ 1 ])            }

  it { should == 1 }
end
