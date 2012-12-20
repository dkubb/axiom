# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection, '#delete' do
  subject { object.delete(other) }

  let(:object)         { described_class.new(operand, [ :id ])                      }
  let(:operand)        { Relation.new(header, LazyEnumerable.new([ [ 1 ], [ 2 ] ])) }
  let(:other_relation) { Relation.new(header, LazyEnumerable.new([ [ 2 ] ]))        }
  let(:header)         { [ [ :id, Integer ] ]                                       }

  shared_examples_for 'Algebra::Projection#delete' do
    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation) }

    its(:header) { should == header }

    it 'deletes the tuples' do
      should == [ [ 1 ] ]
    end
  end

  context 'with a relation having a matching header' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Projection#delete'
  end

  context 'with an array of tuples having a matching header' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Projection#delete'
  end

  context 'with an array of arrays having a matching header' do
    let(:other) { other_relation.map(&:to_ary) }

    it_should_behave_like 'Algebra::Projection#delete'
  end

  context 'with a relation that does not have a matching header' do
    let(:operand)     { Relation.new(base_header, LazyEnumerable.new([ [ 1, 'John Doe' ] ])) }
    let(:other)       { Relation.new(base_header, LazyEnumerable.new([ [ 1, 'John Doe' ] ])) }
    let(:base_header) { [ [ :id, Integer ], [ :name, String, { :required => false } ] ]      }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers must be equivalent') }
  end
end
