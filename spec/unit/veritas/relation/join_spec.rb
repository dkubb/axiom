require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#join' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ] ])
  end

  describe 'without predicate arguments or a block' do
    before do
      @other = Relation.new([ [ :id, Integer ], [ :age, Integer ] ], [ [ 1, 34 ] ])
    end

    subject { @relation.join(@other) }

    it { should be_kind_of(Algebra::Join) }
  end

  describe 'with predicate arguments' do
    before do
      @other     = Relation.new([ Attribute::Boolean.new(:active) ], [ [ true ] ])
      @predicate = @relation[:id].eq(1)
    end

    subject { @relation.join(@other, @predicate) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'should restrict a product' do
      should == [ [ 1, 'Dan Kubb', true ] ]
    end
  end

  describe 'with a block' do
    before do
      @other = Relation.new([ Attribute::Boolean.new(:active) ], [ [ true ] ])
      @block = lambda do |relation|
        relation[:id].eq(1).and(relation[:active].eq(true))
      end
    end

    subject { @relation.join(@other, &@block) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'should restrict a product' do
      should == [ [ 1, 'Dan Kubb', true ] ]
    end
  end
end

describe 'Veritas::Relation#+' do
  it 'is an alias to #join' do
    klass = Relation
    klass.instance_method(:+).should == klass.instance_method(:join)
  end
end
