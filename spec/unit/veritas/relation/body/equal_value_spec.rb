require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#==' do
  before do
    @header = mock('Header')

    @body = Relation::Body.new(@header, [ [ 1 ] ])
  end

  subject { @body == @other }

  describe 'with an equivalent header and equivalent tuples' do
    before do
      @other = Relation::Body.new(@header, @body)
    end

    it { should be_true }
  end

  describe 'with an equivalent header and different tuples' do
    before do
      @other = Relation::Body.new(@header, [ [ 2 ] ])
    end

    it { should be_false }
  end

  describe 'with a different header' do
    before do
      @header.should_receive(:==).at_least(:once).and_return(false)

      @other = Relation::Body.new(@header, @body)
    end

    it { should be_false }
  end
end
