require 'spec_helper'

[ :join, :+ ].each do |method|
  describe "Veritas::Algebra::Join::Methods##{method}" do
    let(:klass)  { Relation                                                                                           }
    let(:object) { klass.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ] ].each) }

    context 'without predicate arguments or a block' do
      subject { object.send(method, other) }

      let(:other) { klass.new([ [ :id, Integer ], [ :age, Integer ] ], [ [ 1, 35 ] ]) }

      it { should be_kind_of(Algebra::Join) }
    end

    context 'with predicate arguments' do
      subject { object.send(method, other, predicate) }

      let(:other)     { klass.new([ Attribute::Boolean.new(:active) ], [ [ true ] ]) }
      let(:predicate) { object[:id].eq(1)                                            }

      it { should be_kind_of(Algebra::Restriction) }

      it 'restricts a product' do
        should == [ [ 1, 'Dan Kubb', true ] ]
      end
    end

    context 'with a block' do
      subject { object.send(method, other, &block) }

      let(:other) { klass.new([ Attribute::Boolean.new(:active) ], [ [ true ] ]) }
      let(:block) do
        lambda do |relation|
          relation[:id].eq(1).and(relation[:active].eq(true))
        end
      end

      it { should be_kind_of(Algebra::Restriction) }

      it 'restricts a product' do
        should == [ [ 1, 'Dan Kubb', true ] ]
      end
    end
  end
end
