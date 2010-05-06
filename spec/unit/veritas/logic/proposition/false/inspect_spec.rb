require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#inspect' do
  let(:false_proposition) { Logic::Proposition::False.instance }

  subject { false_proposition.inspect }

  it { should == 'false' }
end
