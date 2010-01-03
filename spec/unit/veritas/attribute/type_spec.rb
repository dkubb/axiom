require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#type' do
  before do
    @type = Integer

    @attribute = Attribute.new(:id, @type)
  end

  subject { @attribute.type }

  it { should == @type }
end
