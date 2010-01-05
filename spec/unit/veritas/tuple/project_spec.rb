require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#project' do
  before do
    @header          = Relation::Header.new([ [ :name, String ], [ :id, Integer ] ])
    @reversed_header = Relation::Header.new(@header.to_a.reverse)

    @tuple = Tuple.new(@header, [ 'Dan Kubb', 1 ])
  end

  subject { @tuple.project(@reversed_header) }

  it { should be_kind_of(Tuple) }

  it { subject.header.should equal(@reversed_header) }

  it { should == [ 1, 'Dan Kubb' ] }
end
