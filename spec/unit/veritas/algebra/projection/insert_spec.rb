# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection, '#insert' do
  subject { object.insert(other) }

  let(:object) { described_class.new(relation, [ :id ]) }

  context 'when no required attributes are removed' do
    let(:relation) { Relation.new(header, [ [ 1 ] ].each) }
    let(:other)    { Relation.new(header, [ [ 2 ] ].each) }
    let(:header)   { [ [ :id, Integer ] ]                 }

    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation) }

    its(:header) { should == [ [ :id, Integer ] ] }

    it 'inserts the tuples' do
      should == [ [ 1 ], [ 2 ] ]
    end
  end

  context 'when optional attributes are removed' do
    let(:relation) { Relation.new(header, [ [ 1, 'John Doe' ] ].each)                }
    let(:other)    { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ].each)              }
    let(:header)   { [ [ :id, Integer ], [ :name, String, { :required => false } ] ] }

    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation) }

    its(:header) { should == [ [ :id, Integer ] ] }

    it 'inserts the tuples' do
      should == [ [ 1 ], [ 2 ] ]
    end
  end

  context 'when required attributes are removed' do
    let(:relation) { Relation.new(header, [ [ 1, 'John Doe', 25 ] ].each)       }
    let(:other)    { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ].each)         }
    let(:header)   { [ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ] }

    specify { expect { subject }.to raise_error(RequiredAttributesError, 'required attributes name, age have been removed') }
  end

  context 'when the other header does not match the projection' do
    let(:relation) { Relation.new(header, [ [ 1, 'John Doe' ] ].each)                }
    let(:other)    { Relation.new(header, [ [ 2, 'Jane Doe' ] ].each)                }
    let(:header)   { [ [ :id, Integer ], [ :name, String, { :required => false } ] ] }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers must be equivalent') }
  end
end
