require 'spec_helper'

describe 'Veritas::Tuple.coerce' do
  subject { object.coerce(header, argument) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { Tuple                                      }
  let(:tuple)  { object.new(header, [ 1 ])                  }

  context 'when the argument is a Tuple' do
    let(:argument) { tuple }

    it { should equal(argument) }
  end

  context 'when the argument responds to #to_ary' do
    let(:argument) { [ 1 ] }

    it { should be_kind_of(object) }

    it { should == tuple }
  end

  context 'when the argument is not a Tuple and does not respond to #to_ary' do
    let(:argument) { { :id => 1 } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
