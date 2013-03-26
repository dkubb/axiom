# encoding: utf-8

require 'spec_helper'

[ :product, :* ].each do |method|
  describe Algebra::Product::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Relation                                                                            }
    let(:object)          { described_class.new([ [ :id,   Integer ] ], LazyEnumerable.new([ [ 1          ] ])) }
    let(:other)           { described_class.new([ [ :name, String  ] ], LazyEnumerable.new([ [ 'Dan Kubb' ] ])) }

    it { should be_instance_of(Algebra::Product) }
  end
end
