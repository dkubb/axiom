require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#optimize' do
  subject { object.optimize }

  let(:klass)    { Class.new(UnaryOperationSpecs::Object)   }
  let(:body)     { [ [ 1 ] ].each                           }
  let(:relation) { Relation.new([ [ :id, Integer ] ], body) }
  let(:operand)  { relation                                 }
  let(:object)   { klass.new(operand)                       }

  context 'with an empty relation' do
    let(:operand) { Relation::Empty.new([ [ :id, Integer ] ]) }

    it { should equal(operand) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an non-empty relation' do
    it { should equal(object) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizable relation' do
    let(:operand) { relation.project(relation.header) }

    before do
      klass.class_eval do
        def new(operand)
          self.class.new(operand)
        end
      end

      # make #optimized idempotent
      klass.memoize :new_optimized_operation
    end

    it { should_not equal(object) }

    it { should be_instance_of(klass) }

    its(:operand) { should equal(relation) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing materialized relations' do
    let(:body) { [ [ 1 ] ] }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
