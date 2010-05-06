require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#name' do
  let(:name)      { :id                          }
  let(:attribute) { Attribute::Integer.new(name) }

  subject { attribute.name }

  it { should == name }
end
