# encoding: utf-8

require 'spec_helper'

describe Relation, '#hash' do
  subject { object.hash }

  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:body)   { LazyEnumerable.new                        }
  let(:object) { described_class.new(header, body)         }

  before do
    object.should be_instance_of(described_class)
  end

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ header.hash ^ body.to_set.hash }
end
