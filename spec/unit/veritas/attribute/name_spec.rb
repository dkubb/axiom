require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#name' do
  before do
    @name = :id

    @attribute = Veritas::Attribute.new(@name, Integer)
  end

  subject { @attribute.name }

  it { should == @name }
end
