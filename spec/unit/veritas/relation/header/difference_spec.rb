require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#difference' do
  before do
    @attribute1 = mock('Attribute 1')
    @attribute2 = mock('Attribute 2')

    @body  = Relation::Header.new([ @attribute1 ])
    @other = Relation::Header.new([ @attribute2 ])
  end

  subject { @body.difference(@other) }

  it { subject.to_ary.should == [ @attribute1 ] }
end

describe 'Veritas::Relation::Header#-' do
  it 'is an alias to #difference' do
    Relation::Header.instance_method(:-).should == Relation::Header.instance_method(:difference)
  end
end
