require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#difference' do
  before do
    @attribute1 = [ :id,   Integer ]
    @attribute2 = [ :name, String  ]

    @body  = Relation::Header.new([ @attribute1 ])
    @other = Relation::Header.new([ @attribute2 ])
  end

  subject { @body.difference(@other) }

  it { should be_kind_of(Relation::Header) }

  it { should == [ @attribute1 ] }
end

describe 'Veritas::Relation::Header#-' do
  it 'is an alias to #difference' do
    klass = Relation::Header
    klass.instance_method(:-).should == klass.instance_method(:difference)
  end
end
