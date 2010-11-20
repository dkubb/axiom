require 'spec_helper'

describe 'Veritas::Attribute#hash' do
  subject { attribute.hash }

  let(:name)      { :id                                   }
  let(:options)   { { :size => 1..10 }                    }
  let(:attribute) { Attribute::Integer.new(name, options) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Integer) }

  it { should == name.hash ^ options.hash }
end
