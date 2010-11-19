require 'spec_helper'

describe 'Veritas::AbstractClass::ClassMethods#new' do
  subject { klass.new }

  let(:abstract_class) { Class.new { include AbstractClass } }

  context 'called on class' do
    let(:klass) { abstract_class }

    specify { expect { subject }.to raise_error(NotImplementedError, "#{klass} is an abstract class") }
  end

  context 'called on subclass' do
    let(:klass) { Class.new(abstract_class) }

    it { should be_kind_of(klass) }
  end
end
