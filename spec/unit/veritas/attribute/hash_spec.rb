require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#hash' do
  subject { attribute.hash }

  let(:name)      { :id                          }
  let(:attribute) { Attribute::Integer.new(name) }

  it { should be_kind_of(Integer) }

  it { should == name.hash }
end
