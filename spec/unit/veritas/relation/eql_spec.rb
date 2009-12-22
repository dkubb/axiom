require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#eql?' do
  before do
    @header = [ [ :id, Integer ] ]

    @relation = Relation.new(@header, [ [ 1 ] ])
  end

  subject { @relation.eql?(@other) }

  describe 'with equivalent relations' do
    before { @other = @relation.dup }

    it { should be_true }
  end

  describe 'with different relations' do
    before { @other = Relation.new(@header, [ [ 2 ] ]) }

    it { should be_false }
  end

  describe 'with equivalent relations of different classes' do
    before do
      @other = @relation.join(@relation)
    end

    it { should be_false }

    it 'should otherwise be equivalent' do
      @relation.should == @other
    end
  end

end
