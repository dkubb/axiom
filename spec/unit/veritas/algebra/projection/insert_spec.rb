# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection, '#insert' do
  subject { object.insert(other) }

  let(:object)         { described_class.new(operand, [ :id ]) }
  let(:operand)        { Relation.new(header, [ [ 1 ] ].each)  }
  let(:other_relation) { Relation.new(header, [ [ 2 ] ].each)  }
  let(:header)         { [ [ :id, Integer ] ]                  }

  shared_examples_for 'Algebra::Projection#insert' do
    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation) }

    its(:header) { should == header }

    it 'inserts the tuples' do
      should == [ [ 1 ], [ 2 ] ]
    end
  end

  context 'when no required attributes are removed' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Projection#insert'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Projection#insert'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }

    it_should_behave_like 'Algebra::Projection#insert'
  end

  context 'when optional attributes are removed' do
    let(:operand)     { Relation.new(base_header, [ [ 1, 'John Doe' ] ].each)           }
    let(:other)       { Relation.new(header,      [ [ 2 ]             ].each)           }
    let(:base_header) { [ [ :id, Integer ], [ :name, String, { :required => false } ] ] }

    it_should_behave_like 'Algebra::Projection#insert'
  end

  context 'when required attributes are removed' do
    let(:operand)     { Relation.new(base_header, [ [ 1, 'John Doe', 25 ] ].each)  }
    let(:other)       { Relation.new(header,      [ [ 2 ]                 ].each)  }
    let(:base_header) { [ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ] }

    specify { expect { subject }.to raise_error(RequiredAttributesError, 'required attributes name, age have been removed') }
  end

  context 'when the other header does not match the projection' do
    let(:operand)     { Relation.new(base_header, [ [ 1, 'John Doe' ] ].each)           }
    let(:other)       { Relation.new(base_header, [ [ 2, 'Jane Doe' ] ].each)           }
    let(:base_header) { [ [ :id, Integer ], [ :name, String, { :required => false } ] ] }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers must be equivalent') }
  end
end
