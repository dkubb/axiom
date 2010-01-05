require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#intersect' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])

    @body  = Relation::Body.new(@header, [ [ 1 ] ])
    @other = Relation::Body.new(@header, [ [ 2 ] ])
  end

  subject { @body.intersect(@other) }

  it { should be_kind_of(Relation::Body) }

  it { subject.header.should equal(@header) }

  it { should be_empty }
end
