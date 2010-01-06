require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#hash' do
  before do
    @name = :id

    @attribute = Attribute::Integer.new(@name)
  end

  subject { @attribute.hash }

  it { should be_kind_of(Integer) }

  it { should == @name.hash }
end
