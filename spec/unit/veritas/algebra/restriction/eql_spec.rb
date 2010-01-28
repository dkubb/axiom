require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#eql?' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @restriction = @relation.restrict { true }
  end

  subject { @restriction.eql?(@other) }

  describe 'with the same restriction' do
    before do
      @other = @restriction
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@restriction)
    end
  end

  describe 'with an equivalent restriction' do
    before do
      @other = @restriction.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@restriction)
    end
  end

  describe 'with a different restriction' do
    before do
      @other = @relation.restrict { false }
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@restriction)
    end
  end

  describe 'with an equivalent restriction of a different class' do
    before do
      klass = Class.new(Algebra::Restriction)

      @other = klass.new(@relation, proc { true })
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@restriction)
    end
  end
end
