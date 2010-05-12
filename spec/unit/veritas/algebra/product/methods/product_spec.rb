require File.expand_path('../../../../../../spec_helper', __FILE__)

[ :product, :* ].each do |method|
  describe "Veritas::Algebra::Product::Methods##{method}" do
    subject { relation.send(method, other) }

    let(:relation) { Relation.new([ [ :id,   Integer ] ], [ [ 1          ] ]) }
    let(:other)    { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }

    it { should be_kind_of(Algebra::Product) }
  end
end
