require 'spec_helper'

describe 'Veritas::Relation::Header.coerce' do
  subject { object.coerce(argument) }

  let(:object) { Relation::Header }

  context 'when the argument is a Header' do
    let(:argument) { object.new([ [ :id, Integer ] ]) }

    it { should equal(argument) }
  end

  context 'when the argument responds to #to_ary' do
    let(:argument) { [ [ :id, Integer ] ] }

    it { should be_kind_of(object) }

    it { should == argument }
  end

  context 'when the argument is not a Header and does not respond to #to_ary' do
    let(:argument) { { :id => Integer } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
