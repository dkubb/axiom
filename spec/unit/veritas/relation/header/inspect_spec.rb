require 'spec_helper'

describe Relation::Header, '#inspect' do
  subject { object.inspect }

  let(:klass)     { Relation::Header         }
  let(:attribute) { [ :id, Integer ]         }
  let(:object)    { klass.new([ attribute ]) }

  it { should be_kind_of(String) }

  it { should == '[<Attribute::Integer name: id>]' }
end
