require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#body' do
  before do
    @body = [ [ 1 ] ]

    @relation = Relation.new([ [ :id, Integer ] ], @body)
  end

  subject { @relation.body }

  it { should == @body }
end
