require 'spec_helper'

describe 'Veritas::Tuple#[]' do
  subject { object[attribute] }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [ 1 ])                   }

  context 'with a known attribute' do
    let(:attribute) { header[:id] }

    it { should == 1 }
  end

  context 'with an unknown attribute' do
    let(:attribute) { Attribute::Integer.new(:other_id) }

    it { should be_nil }
  end
end
