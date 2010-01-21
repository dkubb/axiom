require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#header' do
  before do
    @empty = Relation::Empty.new([ [ :id, Integer ] ])
  end

  subject { @empty.header }

  it { should == [ [ :id, Integer ] ] }
end
