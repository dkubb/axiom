require 'spec_helper'

describe Relation::Header, '#to_ary' do
  subject { object.to_ary }

  let(:klass)     { Relation::Header         }
  let(:attribute) { [ :id, Integer ]         }
  let(:object)    { klass.new([ attribute ]) }

  it { should be_kind_of(Array) }

  it { should == [ attribute ] }

  it { should be_frozen }
end
