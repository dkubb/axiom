require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#header' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])

    @body = Relation::Body.new([ [ 1 ] ], @header)
  end

  subject { @body.header }

  it { should equal(@header) }
end
