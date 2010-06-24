require 'spec_helper'

describe 'Veritas::Relation::Header.coerce' do
  subject { Relation::Header.coerce(object) }

  context 'when the object is a Header' do
    let(:object) { Relation::Header.new([ [ :id, Integer ] ]) }

    it { should equal(object) }
  end

  context 'when the object responds to #to_ary' do
    let(:object) { [ [ :id, Integer ] ] }

    it { should eql(Relation::Header.new([ Attribute::Integer.new(:id) ])) }
  end

  context 'when the object is not a Header and does not respond to #to_ary' do
    let(:object) { { :id => Integer } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
