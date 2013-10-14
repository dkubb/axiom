# encoding: utf-8

require 'spec_helper'

describe Attribute, '.new' do
  subject { object.new(name, options) }

  let(:name)    { :id }
  let(:options) { {}  }

  [
    Attribute::Boolean,
    Attribute::Class,
    Attribute::Date,
    Attribute::DateTime,
    Attribute::Decimal,
    Attribute::Float,
    Attribute::Integer,
    Attribute::Numeric,
    Attribute::Object,
    Attribute::String,
    Attribute::Time,
 ].each do |described_class|
    context "when called on the Attribute subclass #{described_class}" do
      let(:object) { described_class }

      it 'does not freeze the options' do
        expect(options).not_to be_frozen
        expect { subject }.to_not change(options, :frozen?)
      end

      it { should be_instance_of(object) }
    end
  end

  context 'when called on the Attribute class' do
    let(:object) { described_class }

    specify { expect { subject }.to raise_error(NotImplementedError, "#{object} is an abstract type") }
  end
end
