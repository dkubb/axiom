require 'spec_helper'

describe 'Veritas::Attribute.coerce' do
  subject { Attribute.coerce(object) }

  context 'when the object is an Attribute' do
    let(:object) { Attribute::Integer.new(:id) }

    it { should equal(object) }
  end

  context 'when the object responds to #to_ary' do
    let(:object) { [ :id, Integer ] }

    it { should eql(Attribute::Integer.new(:id)) }
  end
end
