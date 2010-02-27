require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#call' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @header    = Relation::Header.new([ @attribute ])
    @tuple     = Tuple.new(@header, [ 1 ])
  end

  subject { @attribute.call(@tuple) }

  it { should == 1 }
end
