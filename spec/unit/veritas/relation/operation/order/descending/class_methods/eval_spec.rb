require File.expand_path('../../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Descending.eval' do
  describe 'with equal values' do
    subject { Veritas::Relation::Operation::Order::Descending.eval(1, 1) }

    it { should == 0 }
  end

  describe 'with a left value greater than the right' do
    subject { Veritas::Relation::Operation::Order::Descending.eval(2, 1) }

    it { should == -1 }
  end

  describe 'with a left value less than the right' do
    subject { Veritas::Relation::Operation::Order::Descending.eval(1, 2) }

    it { should == 1 }
  end
end
