# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#respond_to?' do
  subject { object.respond_to?(method, include_private) }

  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:header)    { Relation::Header.new([ attribute ]) }
  let(:object)    { described_class.new(header) {}      }

  context 'when the method is an attribute name and include_private is true' do
    let(:method)          { attribute.name }
    let(:include_private) { true           }

    it { should be(true) }
  end

  context 'when the method is an attribute name and include_private is false' do
    let(:method)          { attribute.name }
    let(:include_private) { false          }

    it { should be(true) }
  end

  context 'when the method is not an attribute name and include_private is true' do
    let(:method)          { :unknown }
    let(:include_private) { true     }

    it { should be(false) }
  end

  context 'when the method is not an attribute name and include_private is false' do
    let(:method)          { :unknown }
    let(:include_private) { false    }

    it { should be(false) }
  end
end
