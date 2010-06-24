require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::AbstractClass#new' do
  subject { klass.new }

  context 'called on class' do
    let(:klass) { AbstractClassSpecs::Object }

    specify { expect { subject }.to raise_error(NotImplementedError, 'AbstractClassSpecs::Object is an abstract class') }
  end

  context 'called on subclass' do
    let(:klass) { AbstractClassSpecs::Subclass }

    it { should be_kind_of(AbstractClassSpecs::Subclass) }
  end
end
