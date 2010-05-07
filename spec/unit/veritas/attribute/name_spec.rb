require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#name' do
  subject { attribute.name }

  let(:name)      { :id                          }
  let(:attribute) { Attribute::Integer.new(name) }

  it { should == name }
end
