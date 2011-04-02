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
  ].each do |klass|
    context "when called on the Attribute subclass #{klass}" do
      let(:object) { klass }

      it { should be_kind_of(object) }
    end
  end

  context 'when called on the Attribute class' do
    let(:object) { Attribute }

    specify { expect { subject }.to raise_error(NotImplementedError, "#{object} is an abstract class") }
  end
end
