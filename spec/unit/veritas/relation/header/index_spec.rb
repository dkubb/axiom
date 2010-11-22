require 'spec_helper'

describe 'Veritas::Relation::Header#index' do
  subject { object.index(argument) }

  let(:klass)     { Relation::Header         }
  let(:attribute) { [ :id, Integer ]         }
  let(:object)    { klass.new([ attribute ]) }

  context 'when the argument is a known attribute' do
    let(:argument) { attribute }

    it { should == 0 }
  end

  context 'when the argument is an unknown attribute' do
    let(:argument) { [ :name, String ] }

    it { should be_nil }
  end
end
