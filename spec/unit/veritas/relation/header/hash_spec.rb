require 'spec_helper'

describe 'Veritas::Relation::Header#hash' do
  subject { object.hash }

  let(:klass)      { Relation::Header                }
  let(:attributes) { [ Attribute::Integer.new(:id) ] }
  let(:object)     { klass.new(attributes)           }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == klass.hash ^ attributes.hash }
end
