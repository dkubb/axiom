require File.expand_path('../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::AbstractClass#new' do
  subject { klass.new }

  context 'called on class' do
    let(:klass) { AbstractClassSpecs::Object }

    specify { method(:subject).should raise_error(NotImplementedError, 'AbstractClassSpecs::Object is an abstract class') }
  end

  context 'called on subclass' do
    let(:klass) { AbstractClassSpecs::Subclass }

    it { should be_kind_of(AbstractClassSpecs::Subclass) }
  end
end
