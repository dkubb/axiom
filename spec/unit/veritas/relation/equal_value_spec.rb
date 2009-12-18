require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#==' do
  before do
    @header = [ [ :id, Integer ] ]
    @body   = [ [ 1 ] ]

    @relation = Relation.new(@header, @body)
  end

  describe 'with equivalent relations' do
    before { @other = Relation.new(@header, @body) }

    subject { @relation == @other }

    it { should be_true }
  end

  describe 'with different relations' do
    before { @other = Relation.new(@header, [ [ 2 ] ]) }

    subject { @relation == @other }

    it { should be_false }
  end
end
