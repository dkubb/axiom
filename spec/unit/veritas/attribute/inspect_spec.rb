require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#inspect' do
  let(:attribute) { Attribute::Integer.new(:id) }

  subject { attribute.inspect }

  it { should be_kind_of(String) }

  it { should == '<Attribute::Integer name: id>' }
end
