require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#eql?' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])

    @body = Relation::Body.new([ [ 1 ] ], @header)
  end

  subject { @body.eql?(@other) }

  describe 'with the same body' do
    before do
      @other = @body
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@body)
    end
  end

  describe 'with an equivalent body' do
    before do
      @other = @body.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@body)
    end
  end

  describe 'with an equivalent header and different tuples' do
    before do
      @other = Relation::Body.new([ [ 2 ] ], @header)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@body)
    end
  end

  describe 'with a different header' do
    before do
      header = Relation::Header.new([ [ :name, String ] ])
      @other = Relation::Body.new(@body, header)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@body)
    end
  end

  describe 'with an equivalent object responding to #to_set' do
    before do
      @other = Set[ [ 1 ] ]
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@body)
    end
  end

  describe 'with a different object responding to #to_set' do
    before do
      @other = Set[ [ 2 ] ]
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@body)
    end
  end

  describe 'with an equivalent header and equivalent tuples with attributes in a different order' do
    before do
      attribute1 = [ :id,   Integer ]
      attribute2 = [ :name, String  ]

      header1 = Relation::Header.new([ attribute1, attribute2 ])
      header2 = Relation::Header.new([ attribute2, attribute1 ])

      @body  = Relation::Body.new([ [ 1, 'Dan Kubb' ] ], header1)
      @other = Relation::Body.new([ [ 'Dan Kubb', 1 ] ], header2)
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@body)
    end
  end
end
