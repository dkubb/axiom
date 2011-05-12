require 'spec_helper'

describe Function, '.rename_attributes' do
  subject { object.rename_attributes(operand, aliases) }

  let(:object)  { described_class                                           }
  let(:header)  { Relation::Header.new([ [ :id, Integer ] ])                }
  let(:aliases) { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }

  context 'with an attribute' do
    let(:operand) { header[:id] }

    it { should == Attribute::Integer.new(:other_id) }
  end

  context 'with a function' do
    let(:operand) { header[:id].eq(1) }

    it { should == Attribute::Integer.new(:other_id).eq(1) }
  end

  context 'with a literal' do
    let(:operand) { 1 }

    it { should == 1 }
  end
end
