require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute.new' do
  subject { klass.new(:id) }

  context 'when called on the Attribute class' do
    let(:klass) { Attribute }

    specify { method(:subject).should raise_error(NotImplementedError, 'Veritas::Attribute is an abstract class') }
  end

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
      let(:klass) { klass }

      it { should be_kind_of(Attribute) }

      it { should be_kind_of(klass) }
    end
  end
end
