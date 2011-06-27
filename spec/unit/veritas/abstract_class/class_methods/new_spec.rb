# encoding: utf-8

require 'spec_helper'

describe AbstractClass::ClassMethods, '#new' do
  subject { object.new }

  let(:abstract_class) { Class.new { include AbstractClass } }

  context 'called on a subclass' do
    let(:object) { Class.new(abstract_class) }

    it { should be_instance_of(object) }
  end

  context 'called on the class' do
    let(:object) { abstract_class }

    specify { expect { subject }.to raise_error(NotImplementedError, "#{object} is an abstract class") }
  end
end
