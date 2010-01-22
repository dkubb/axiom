require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#optimize' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
  end

  subject { @rename.optimize }

  describe 'containing a relation' do
    before do
      @rename = Algebra::Rename.new(@relation, :id => :other_id)
    end

    it { should be_kind_of(Algebra::Rename) }

    it 'should set aliases the same as the original rename' do
      subject.aliases.should == @rename.aliases
    end

    it { subject.relation.should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an empty relation' do
    before do
      @empty = Relation::Empty.new(@relation.header)

      @rename = Algebra::Rename.new(@empty, :id => :other_id)
    end

    it { should be_kind_of(Relation::Empty) }

    it { subject.header.should == @rename.header }

    it 'should return the same tuples as the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an optimizable relation' do
    before do
      @projection = @relation.project(@relation.header)

      @rename = Algebra::Rename.new(@projection, :id => :other_id)
    end

    it { should be_kind_of(Algebra::Rename) }

    it 'should set aliases the same as the original rename' do
      subject.aliases.should == @rename.aliases
    end

    it { subject.relation.should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a rename operation' do
    before do
      @rename = Algebra::Rename.new(@relation, :id   => :other_id)
      @rename = Algebra::Rename.new(@rename,   :name => :other_name)
    end

    it { should be_kind_of(Algebra::Rename) }

    it 'should set aliases as a union of both aliases' do
      subject.aliases.should == { :id => :other_id, :name => :other_name }
    end

    it { subject.relation.should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a rename operation with overlapping aliases' do
    before do
      @rename = Algebra::Rename.new(@relation, :id       => :other_id)
      @rename = Algebra::Rename.new(@rename,   :other_id => :another_id)
    end

    it { should be_kind_of(Algebra::Rename) }

    it 'should set aliases as a union of both aliases' do
      subject.aliases.should == { :id => :another_id }
    end

    it { subject.relation.should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an inverse rename operation' do
    before do
      @rename = Algebra::Rename.new(@relation, :id       => :other_id)
      @rename = Algebra::Rename.new(@rename,   :other_id => :id)
    end

    it { should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @rename
    end
  end
end
