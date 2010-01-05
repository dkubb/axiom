require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#project' do
  before do
    header = Relation::Header.new([ [ :name, String ], [ :id, Integer ] ])

    @reversed_header = Relation::Header.new(header.to_a.reverse)

    @body = Relation::Body.new(header, [ [ 'Dan Kubb', 1 ] ])
  end

  subject { @body.project(@reversed_header) }

  it { should be_kind_of(Relation::Body) }

  it { subject.header.should equal(@reversed_header) }

  it { should == [ [ 1, 'Dan Kubb' ] ] }
end
