require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Inclusion#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @inclusion = @attribute.in([ 1 ])
  end

  subject { @inclusion.inspect }

  it { should == "#{@attribute.inspect} IN(#{[ 1 ].inspect})" }
end
