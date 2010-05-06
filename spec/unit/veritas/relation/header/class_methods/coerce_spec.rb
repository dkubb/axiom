require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header.coerce' do
  subject { Relation::Header.coerce(object) }

  describe 'when the object is a Header' do
    let(:object) { Relation::Header.new([ [ :id, Integer ] ]) }

    it { should equal(object) }
  end

  describe 'when the object responds to #to_ary' do
    let(:object) { [ [ :id, Integer ] ] }

    it { should eql(Relation::Header.new([ Attribute::Integer.new(:id) ])) }
  end

  describe 'when the object is not a Header and does not respond to #to_ary' do
    let(:object) { { :id => Integer } }

    it { method(:subject).should raise_error(NoMethodError) }
  end
end
