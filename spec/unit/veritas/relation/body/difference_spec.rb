require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#difference' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple1 = [ 1 ]
    @tuple2 = [ 2 ]

    @body  = Relation::Body.new(@header, [ @tuple1 ])
    @other = Relation::Body.new(@header, [ @tuple2 ])
  end

  subject { @body.difference(@other) }

  it { should be_kind_of(Relation::Body) }

  it { subject.header.should equal(@header) }

  it { should == Set[ @tuple1 ] }
end
