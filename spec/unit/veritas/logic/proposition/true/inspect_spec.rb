require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#inspect' do
  let(:true_proposition) { Logic::Proposition::True.instance }

  subject { true_proposition.inspect }

  it { should == 'true' }
end
