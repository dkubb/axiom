require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple.coerce' do
  subject { Tuple.coerce(header, object) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

  context 'when the object is a Tuple' do
    let(:object) { Tuple.new(header, [ 1 ]) }

    it { should equal(object) }
  end

  context 'when the object responds to #to_ary' do
    let(:object) { [ 1 ] }

    it { should eql(Tuple.new(header, [ 1 ])) }
  end
end
