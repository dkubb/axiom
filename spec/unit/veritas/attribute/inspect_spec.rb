require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @attribute.inspect }

  it { should be_kind_of(String) }

  it { should == '<Attribute::Integer name: id>' }
end
