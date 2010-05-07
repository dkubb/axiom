require File.expand_path('../../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Descending.eval' do
  context 'with equal values' do
    subject { Relation::Operation::Order::Descending.eval(1, 1) }

    it { should == 0 }
  end

  context 'with a left value greater than the right' do
    subject { Relation::Operation::Order::Descending.eval(2, 1) }

    it { should == -1 }
  end

  context 'with a left value less than the right' do
    subject { Relation::Operation::Order::Descending.eval(1, 2) }

    it { should == 1 }
  end
end
