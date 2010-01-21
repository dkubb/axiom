require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#optimize' do
  describe 'with an empty Enumerable, responding to size' do
    before do
      @relation = Relation.new([ [ :id, Integer ] ], [])
    end

    subject { @relation.optimize }

    it { should be_kind_of(Relation::Empty) }

    it { should == @relation }
  end

  describe 'with an nonempty Enumerable' do
    before do
      @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    end

    subject { @relation.optimize }

    it { should equal(@relation) }

    it { should == [ [ 1 ] ] }
  end
end
