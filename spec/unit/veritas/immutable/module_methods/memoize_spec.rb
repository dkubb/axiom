# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

shared_examples_for 'memoizes method' do
  it 'memoizes the instance method' do
    subject
    instance = object.new
    instance.send(method).should equal(instance.send(method))
  end

  it 'creates a method that returns a frozen value' do
    subject
    instance = object.new
    instance.send(method).should be_frozen
  end

  specification = proc do
    object.send(:define_method, method) do
      caller
    end

    subject

    file, line = object.new.send(method).first.split(':')[0, 2]

    File.expand_path(file).should eql(File.expand_path('../../../../../../lib/veritas/support/immutable.rb', __FILE__))
    line.to_i.should eql(185)
  end

  it 'sets the file and line number properly' do
    if RUBY_PLATFORM[/java/]
      pending('Kernel#caller returns the incorrect line number in JRuby', &specification)
    else
      instance_eval(&specification)
    end
  end
end

describe Immutable::ModuleMethods, '#memoize' do
  subject { object.memoize(method) }

  let(:object) { Class.new(ImmutableSpecs::Object) }

  context 'public method' do
    let(:method) { :public_method }

    it { should equal(object) }

    it_should_behave_like 'memoizes method'

    it 'is still a public method' do
      should be_public_method_defined(method)
    end
  end

  context 'protected method' do
    let(:method) { :protected_method }

    it { should equal(object) }

    it_should_behave_like 'memoizes method'

    it 'is still a protected method' do
      should be_protected_method_defined(method)
    end
  end

  context 'private method' do
    let(:method) { :private_method }

    it { should equal(object) }

    it_should_behave_like 'memoizes method'

    it 'is still a private method' do
      should be_private_method_defined(method)
    end
  end
end
