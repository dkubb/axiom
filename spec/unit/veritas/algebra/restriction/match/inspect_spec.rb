require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Match#inspect' do
  before do
    @attribute = Attribute::String.new(:name)

    @match = @attribute.match(/Dan Kubb/)
  end

  subject { @match.inspect }

  it { should == "#{@attribute.inspect} =~ #{/Dan Kubb/.inspect}" }
end
