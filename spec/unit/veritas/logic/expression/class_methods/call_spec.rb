require 'spec_helper'

describe 'Veritas::Logic::Expression.call' do
  subject { klass.call }

  let(:klass) do
    Class.new(Logic::Expression) do
      def self.name
        'AnonymousClass'
      end
    end
  end

  specify { expect { subject }.to raise_error(NotImplementedError, 'AnonymousClass.call must be implemented') }
end
