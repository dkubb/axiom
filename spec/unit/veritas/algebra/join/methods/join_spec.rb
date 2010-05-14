require 'spec_helper'

[ :join, :+ ].each do |method|
  describe "Veritas::Algebra::Join::Methods##{method}" do
    subject { relation.send(method, other, *args, &block) }

    let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ] ]) }

    context 'without predicate arguments or a block' do
      let(:other) { Relation.new([ [ :id, Integer ], [ :age, Integer ] ], [ [ 1, 34 ] ]) }
      let(:args)  { []                                                                   }
      let(:block) { nil                                                                  }

      it { should be_kind_of(Algebra::Join) }
    end

    context 'with predicate arguments' do
      let(:other)     { Relation.new([ Attribute::Boolean.new(:active) ], [ [ true ] ]) }
      let(:predicate) { relation[:id].eq(1)                                             }
      let(:args)      { [ predicate ]                                                   }
      let(:block)     { nil                                                             }

      it { should be_kind_of(Algebra::Restriction) }

      it 'restricts a product' do
        should == [ [ 1, 'Dan Kubb', true ] ]
      end
    end

    context 'with a block' do
      let(:other) { Relation.new([ Attribute::Boolean.new(:active) ], [ [ true ] ]) }
      let(:args)  { []                                                              }
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
