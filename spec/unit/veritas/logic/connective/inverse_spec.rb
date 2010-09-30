require 'spec_helper'

describe 'Veritas::Logic::Connective#inverse' do
  subject { object.inverse }

  before do
    klass.class_eval do
      def inspect
        'Connective()'
      end
    end
  end

  let(:klass)  { Class.new(Logic::Connective) }
  let(:object) { klass.new                    }

  it { should be_kind_of(Logic::Connective::Negation) }

  its(:operand) { should equal(object) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end

  it_should_behave_like 'an idempotent method'
end
