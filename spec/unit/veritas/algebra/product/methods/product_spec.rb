# encoding: utf-8

require 'spec_helper'

[ :product, :* ].each do |method|
  describe Algebra::Product::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Relation                                                             }
    let(:object)          { described_class.new([ [ :id,   Integer ] ], [ [ 1          ] ].each) }
    let(:other)           { described_class.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ].each) }

    it { should be_kind_of(Algebra::Product) }
  end
end
