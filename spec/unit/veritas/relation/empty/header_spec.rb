require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#header' do
  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  subject { empty.header }

  it { should == [ [ :id, Integer ] ] }
end
