require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#eql?' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @aliases  = { :id => :other_id }

    @rename = @relation.rename(@aliases)
  end

  subject { @rename.eql?(@other) }

  describe 'with the same rename' do
    before do
      @other = @rename
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@rename)
    end
  end

  describe 'with an equivalent rename' do
    before do
      @other = @rename.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@rename)
    end
  end

  describe 'with a different rename' do
    before do
      @other = @relation.rename(:id => :another_id)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@rename)
    end
  end

  describe 'with an equivalent rename of a different class' do
    before do
      klass = Class.new(Algebra::Rename)

      @other = klass.new(@relation, @aliases)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@rename)
    end
  end
end
