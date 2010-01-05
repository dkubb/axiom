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

  # TODO: remove this once Set is no longer used inside the body because
  # it alters the == method, so that eql? is used to match each tuple,
  # rather than ==, which will properly coerce the Array into a Tuple.
  it { subject.to_a.should == [ [ 1, 'Dan Kubb' ] ] }
end
