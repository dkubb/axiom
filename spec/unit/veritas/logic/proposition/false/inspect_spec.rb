require 'spec_helper'

describe 'Veritas::Logic::Proposition::False#inspect' do
  subject { false_proposition.inspect }

  let(:false_proposition) { Logic::Proposition::False.instance }

  it { should == 'false' }
end
