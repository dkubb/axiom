require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate.rename_operand' do
  let(:attribute) { Attribute::Integer.new(:id)       }
  let(:other)     { Attribute::Integer.new(:other_id) }
  let(:aliases)   { { :id => :other_id }              }

  subject { Logic::Predicate.rename_operand(operand, aliases) }

  context 'when the operand responds to #rename' do
    let(:operand) { attribute }

    it { should eql(Attribute::Integer.new(:other_id)) }
  end

  context 'when the operand does not respond to #rename' do
    let(:operand) { other }

    it { should equal(operand) }
  end
end
