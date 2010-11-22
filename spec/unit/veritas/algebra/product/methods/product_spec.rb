require 'spec_helper'

[ :product, :* ].each do |method|
  describe "Veritas::Algebra::Product::Methods##{method}" do
    subject { object.send(method, other) }

    let(:klass)  { Relation                                                   }
    let(:object) { klass.new([ [ :id,   Integer ] ], [ [ 1          ] ].each) }
    let(:other)  { klass.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ].each) }

    it { should be_kind_of(Algebra::Product) }
  end
end
