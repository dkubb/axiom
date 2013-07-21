# encoding: utf-8

require 'spec_helper'

[:join, :+].each do |method|
  describe Algebra::Join::Methods, "##{method}" do
    let(:described_class) { Relation                                                                                                       }
    let(:object)          { described_class.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb'], [2, 'Dan Kubb']])) }

    context 'without a block' do
      subject { object.send(method, other) }

      let(:other) { described_class.new([[:id, Integer], [:age, Integer]], LazyEnumerable.new([[1, 35]])) }

      it { should be_instance_of(Algebra::Join) }
    end

    context 'with a block' do
      subject { object.send(method, other, &block) }

      let(:other) { described_class.new([[:active, TrueClass]], [[true]]) }
      let(:block) do
        lambda do |relation|
          relation[:id].eq(1).and(relation[:active].eq(true))
        end
      end

      it { should be_instance_of(Algebra::Restriction) }

      it 'restricts a product' do
        should == [[1, 'Dan Kubb', true]]
      end
    end
  end
end
