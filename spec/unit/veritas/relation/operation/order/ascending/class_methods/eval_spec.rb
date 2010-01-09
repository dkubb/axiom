require File.expand_path('../../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Ascending.eval' do
  describe 'with equal values' do
    subject { Relation::Operation::Order::Ascending.eval(1, 1) }

    it { should == 0 }
  end

  describe 'with a left value greater than the right' do
    subject { Relation::Operation::Order::Ascending.eval(2, 1) }

    it { should == 1 }
  end

  describe 'with a left value less than the right' do
    subject { Relation::Operation::Order::Ascending.eval(1, 2) }

    it { should == -1 }
  end
end
