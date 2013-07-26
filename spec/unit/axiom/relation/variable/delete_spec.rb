# encoding: utf-8

require 'spec_helper'

describe Relation::Variable, '#delete' do
  subject { object.delete(other) }

  let(:object)   { described_class.new(relation)              }
  let(:relation) { Relation::Base.new('users', header, [[1]]) }
  let(:other)    { [[1]]                                      }
  let(:header)   { [[:id, Integer]]                           }

  it { should be_instance_of(described_class) }

  it { should_not be_materialized }

  it { should be_empty }
end
