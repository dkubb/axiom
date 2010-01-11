require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#project' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])

    @new_header = @header.rename(:id => :other_id)

    @body = Relation::Body.new(@header, [ [ 1 ] ])
  end

  subject { @body.rename(@new_header) }

  it { should be_kind_of(Relation::Body) }

  it { subject.header.should equal(@new_header) }

  it { should == [ [ 1 ] ] }
end
