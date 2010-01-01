require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#normalize' do
  before do
    header = Relation::Header.new([ [ :name, String ], [ :id, Integer ] ])
    body   = [ [ 'Dan Kubb', 1 ] ]

    @body  = Relation::Body.new(header, body)
  end

  subject { @body.normalize }

  it { should be_kind_of(Set) }

  it { should == Set[ [ 1, 'Dan Kubb' ] ] }
end
