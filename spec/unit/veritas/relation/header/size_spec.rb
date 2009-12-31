require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#size' do
  before do
    @header = Relation::Header.new([ mock('Attribute') ])
  end

  subject { @header.size }

  it { should == 1 }
end
