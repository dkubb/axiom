require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#eql?' do
  before do
    @header = [ [ :id, Integer ] ]

    @relation = Relation.new(@header, [ [ 1 ] ])
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

  describe 'with an equivalent relation of different classes' do
    before do
      @other = @relation.join(@relation)
    end

    it { should be_false }

    it 'should otherwise be equivalent' do
      @relation.should == @other
    end
  end
end
