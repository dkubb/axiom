# encoding: utf-8

require 'spec_helper'

describe Tuple, '#data' do
  subject { object.data }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { described_class.new(header, [ 1 ])         }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Hash) }

  it { should eql(header[:id] => 1) }
end
