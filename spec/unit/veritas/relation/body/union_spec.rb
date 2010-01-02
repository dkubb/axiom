require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#union' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @tuple1 = [ 1, 'Dan Kubb' ]
    @tuple2 = [ 2, 'John Doe' ]

    @body  = Relation::Body.new(@header, [ @tuple1 ])
    @other = Relation::Body.new(@header, [ @tuple2 ])
  end

  subject { @body.union(@other) }

  it { should be_kind_of(Relation::Body) }

  it { subject.header.should equal(@header) }

  it { subject.to_set.should == Set[ @tuple1, @tuple2 ] }
end

describe 'Veritas::Relation::Body#|' do
  it 'is an alias to #union' do
    Relation::Body.instance_method(:|).should == Relation::Body.instance_method(:union)
  end
end
