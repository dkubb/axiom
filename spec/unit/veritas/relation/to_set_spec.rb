# encoding: utf-8

require 'spec_helper'

describe Relation, '#to_set' do
  subject { object.to_set }

  let(:object) { described_class.new(header, body)             }
  let(:header) { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:body)   { LazyEnumerable.new([ [ 1 ] ])                 }

  before do
    object.should be_instance_of(described_class)
  end

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Set) }

  it { should == Set[ Tuple.new(header, [ 1 ]) ] }
end
