# encoding: utf-8

require 'spec_helper'

describe Attribute, '.inherited' do
  subject { object.inherited(descendant) }

  let(:object)     { Class.new(described_class) }
  let(:descendant) { Class.new                  }

  it_should_behave_like 'a command method'

  it 'prepends the class to the descendants' do
    object.descendants << original = Class.new
    expect { subject }.to change { object.descendants.dup }.
      from([ original ]).
      to([ descendant, original ])
  end

  it 'prepends the class to the superclass descendants' do
    expect { subject }.to change { object.superclass.descendants.dup }.
      from([ object ].concat(@original_descendants)).
      to([ descendant, object ].concat(@original_descendants))
  end
end
