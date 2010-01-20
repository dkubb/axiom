require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#hash' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @unary_operation = UnaryOperationSpecs::Object.new(@relation)
  end

  subject { @unary_operation.hash }

  it { should be_kind_of(Integer) }

  it { should == @relation.hash }
end
