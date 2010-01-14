require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#first' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @ordered  = @relation.order { |r| r[:id] }
  end

  describe 'with no arguments' do
    subject { @ordered.first }

    it { should be_kind_of(Relation::Operation::Limit) }

    it 'should set the default limit' do
      subject.to_int.should == 1
    end

    it 'should return the expected tuples' do
      subject.should == [ [ 1 ] ]
    end
  end

  describe 'with a limit' do
    subject { @ordered.first(2) }

    it { should be_kind_of(Relation::Operation::Limit) }

    it 'should set the limit' do
      subject.to_int.should == 2
    end

    it 'should return the expected tuples' do
      subject.should == [ [ 1 ], [ 2 ] ]
    end
  end
end
