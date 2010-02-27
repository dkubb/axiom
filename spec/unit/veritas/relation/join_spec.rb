require File.expand_path('../../../../spec_helper', __FILE__)

[ :join, :+ ].each do |method|
  describe "Veritas::Relation##{method}" do
    before do
      @relation = Relation.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ] ])
    end

    describe 'without predicate arguments or a block' do
      before do
        @other = Relation.new([ [ :id, Integer ], [ :age, Integer ] ], [ [ 1, 34 ] ])
      end

      subject { @relation.send(method, @other) }

      it { should be_kind_of(Algebra::Join) }
    end

    describe 'with predicate arguments' do
      before do
        @other     = Relation.new([ Attribute::Boolean.new(:active) ], [ [ true ] ])
        @predicate = @relation[:id].eq(1)
      end

      subject { @relation.send(method, @other, @predicate) }

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

      subject { @relation.send(method, @other, &@block) }

      it { should be_kind_of(Algebra::Restriction) }

      it 'should restrict a product' do
        should == [ [ 1, 'Dan Kubb', true ] ]
      end
    end
  end
end
