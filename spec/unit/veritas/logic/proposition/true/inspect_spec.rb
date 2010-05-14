require 'spec_helper'

describe 'Veritas::Logic::Proposition::True#inspect' do
  subject { true_proposition.inspect }

  let(:true_proposition) { Logic::Proposition::True.instance }

  it { should == 'true' }
end
