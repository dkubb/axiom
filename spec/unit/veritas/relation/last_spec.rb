require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#last' do
  before do
    pending 'Relations need to be able to delegate #directions to subordinates'
  end

  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @ordered  = @relation.order { |r| r[:id] }
  end

  describe 'with no arguments' do
    subject { @ordered.last }

    it { should be_kind_of(Relation::Operation::Limit) }

    it 'should set the default limit' do
      subject.to_int.should == 1
    end

    it 'should return the expected tuples' do
      subject.body.should == [ [ 3 ] ]
    end
  end

  describe 'with a limit' do
    subject { @ordered.last(2) }

    it { should be_kind_of(Relation::Operation::Limit) }

    it 'should set the limit' do
      subject.to_int.should == 2
    end

    it 'should return the expected tuples' do
      subject.body.should == [ [ 2 ], [ 3 ] ]
    end
  end
end
