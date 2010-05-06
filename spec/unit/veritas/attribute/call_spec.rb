require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#call' do
  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:header)    { Relation::Header.new([ attribute ]) }
  let(:tuple)     { Tuple.new(header, [ 1 ])            }

  subject { attribute.call(tuple) }

  it { should == 1 }
end
