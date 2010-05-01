require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#==' do
  before do
    @header = [ [ :id, Integer ] ]
    @tuples = [ [ 1 ] ]

    @relation = Relation.new(@header, @tuples)
  end

  subject { @relation == @other }

  describe 'with the same relation' do
    before do
      @other = @relation
    end

    it { should be(true) }

    it 'is symmetric' do
      should == (@other == @relation)
    end
  end

  describe 'with an equivalent relation' do
    before do
      @other = @relation.dup
    end

    it { should be(true) }

    it 'is symmetric' do
      should == (@other == @relation)
    end
  end

  describe 'with an equivalent header and different tuples' do
    before do
      @other = Relation.new(@header, [ [ 2 ] ])
    end

    it { should be(false) }

    it 'is symmetric' do
      should == (@other == @relation)
    end
  end

  describe 'with a different header' do
    before do
      @other = Relation.new([ [ :name, String ] ], @relation)
    end

    it { should be(false) }

    it 'is symmetric' do
      should == (@other == @relation)
    end
  end

  describe 'with an equivalent object responding to #to_set' do
    before do
      @other = Set[ [ 1 ] ]
    end

    it { should be(true) }

    it 'is symmetric' do
      pending 'Set#== should call to_set on other' do
        should == (@other == @relation)
      end
    end
  end

  describe 'with a different object responding to #to_set' do
    before do
      @other = Set[ [ 2 ] ]
    end

    it { should be(false) }

    it 'is symmetric' do
      should == (@other == @relation)
    end
  end

  describe 'with an equivalent header and equivalent tuples with attributes in a different order' do
    before do
      attribute1 = [ :id,   Integer ]
      attribute2 = [ :name, String  ]

      header1 = Relation::Header.new([ attribute1, attribute2 ])
      header2 = Relation::Header.new([ attribute2, attribute1 ])

      @relation = Relation.new(header1, [ [ 1, 'Dan Kubb' ] ])
      @other    = Relation.new(header2, [ [ 'Dan Kubb', 1 ] ])
    end

    it { should be(true) }

    it 'is symmetric' do
      should == (@other == @relation)
    end
  end

  describe 'with an equivalent relation of a different class' do
    before do
      klass = Class.new(Relation)

      @other = klass.new(@header, @tuples)
    end

    it { should be(true) }

    it 'is symmetric' do
      should == (@other == @relation)
    end
  end
end
