require 'spec_helper'

describe 'Veritas::Attribute#hash' do
  subject { attribute.hash }

  let(:name)      { :id                          }
  let(:attribute) { Attribute::Integer.new(name) }

  it { should be_kind_of(Integer) }

  it { should == name.hash }
end
