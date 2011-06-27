# encoding: utf-8

require 'spec_helper'

describe Attribute, '.new' do
  subject { object.new(name) }

  let(:name) { :id }

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

      it { should be_instance_of(object) }
    end
  end

  context 'when called on the Attribute class' do
    let(:object) { described_class }

    specify { expect { subject }.to raise_error(NotImplementedError, "#{object} is an abstract class") }
  end
end
