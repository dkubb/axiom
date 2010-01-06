require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#name' do
  before do
    @name = :id

    @attribute = Attribute::Integer.new(@name)
  end

  subject { @attribute.name }

  it { should == @name }
end
