# encoding: utf-8

require 'spec_helper'

describe Relation::Variable, '.new' do
  subject { object.new(relation) }

  let(:object) { described_class  }
  let(:header) { [[:id, Integer]] }
  let(:body)   { [[1]]            }

  context 'with a materialized relation' do
    let(:relation) { Relation.new(header, body) }

    it { should be_instance_of(described_class::Materialized) }

    its(:header) { should == header }

    it { should == body }

    it { should be_materialized }
  end

  context 'with a non-materialized relation' do
    let(:relation) { Relation::Base.new('users', header, body) }

    it { should be_instance_of(described_class) }

    its(:header) { should == header }

    it { should == body }

    it { should_not be_materialized }
  end
end
