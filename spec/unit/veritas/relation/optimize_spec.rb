require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#optimize' do
  subject { @relation.optimize }

  describe 'with an empty Enumerable, responding to size' do
    before do
      @relation = Relation.new([ [ :id, Integer ] ], [])
    end

    it { should be_instance_of(Relation::Empty) }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @relation
    end
  end

  describe 'with an nonempty Enumerable' do
    before do
      @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    end

    it { should equal(@relation) }
  end
end
