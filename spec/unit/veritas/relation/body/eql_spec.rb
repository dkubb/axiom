require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#eql?' do
  before do
    @header = mock('Header')

    @body = Relation::Body.new(@header, [ [ 1 ] ])
  end

  subject { @body.eql?(@other) }

  describe 'with an equivalent body of different classes' do
    before do
      klass = Class.new(Relation::Body)

      @other = klass.new(@header, @body)
    end

    it { should be_false }

    it 'should otherwise be equivalent' do
      @body.should == @other
    end
  end

  describe 'with an equivalent body' do
    before do
      @other = Relation::Body.new(@header, @body)
    end

    it { should be_true }
  end

  describe 'with a different body' do
    before do
      @other = Relation::Body.new(@header, [ [ 2 ] ])
    end

    it { should be_false }
  end
end
