require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#size' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { @header.size }

  it { should == 1 }
end
