require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#[]' do
  subject { tuple[attribute] }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  context 'with a known attribute' do
    let(:attribute) { header[:id] }

    it { should == 1 }
  end

  context 'with an known attribute' do
    let(:attribute) { Attribute::Integer.new(:other_id) }

    it { should be_nil }
  end
end
