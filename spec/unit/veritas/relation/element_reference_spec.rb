require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#[]' do
  before do
    @header = [ [ :id, Integer ] ]

    @relation = Relation.new(@header, [])
  end

  subject { @relation[:id] }

  it { should be_kind_of(Attribute::Integer) }

  it { should == [ :id, Integer ] }
end
