require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::CombineOperation#body' do
  before do
    @header = [ [ :id, Integer ] ]

    @left  = Relation.new(@header, [ [ 1 ] ])
    @right = Relation.new(@header, [ [ 2 ] ])

    @combine_operation = CombineOperationSpecs::Object.new(@left, @right)
  end

  subject { @combine_operation.body }

  it { method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#combine_bodies must be implemented') }

  it 'should return the expected body' do
    @combine_operation.should_receive(:combine_bodies).and_return([])
    subject.header.should == @header
    subject.should == []
  end
end
