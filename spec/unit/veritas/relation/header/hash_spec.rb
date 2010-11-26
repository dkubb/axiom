require 'spec_helper'

describe 'Veritas::Relation::Header#hash' do
  subject { object.hash }

  let(:klass)      { Relation::Header                }
  let(:attributes) { [ Attribute::Integer.new(:id) ] }
  let(:object)     { klass.new(attributes)           }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ attributes.hash }
end
