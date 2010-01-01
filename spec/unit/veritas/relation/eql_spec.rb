require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#eql?' do
  before do
    @header = [ [ :id, Integer ] ]
    @body   = [ [ 1 ] ]

    @relation = Relation.new(@header, @body)
  end

  subject { @relation.eql?(@other) }

  describe 'with an equivalent relation' do
    before do
      @other = @relation.dup
    end

    it { should be_true }
  end

  describe 'with a different relation' do
    before do
      @other = Relation.new(@header, [ [ 2 ] ])
    end

    it { should be_false }
  end

  describe 'with an equivalent relation of a different class' do
    before do
      klass = Class.new(Relation)

      @other = klass.new(@header, @body)
    end

    it { should be_false }

    it 'should otherwise be equivalent' do
      @relation.should == @other
    end
  end
end
