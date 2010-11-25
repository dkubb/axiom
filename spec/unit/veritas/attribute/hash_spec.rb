require 'spec_helper'

describe 'Veritas::Attribute#hash' do
  subject { object.hash }

  let(:klass)   { Attribute::Integer       }
  let(:name)    { :id                      }
  let(:options) { { :size => 1..10 }       }
  let(:object)  { klass.new(name, options) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == klass.hash ^ name.hash ^ options.hash }
end
