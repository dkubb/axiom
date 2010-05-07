require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute.new' do
  context 'when called on the Attribute class' do
    subject { Attribute.new(:id) }

    it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Attribute is an abstract class') }
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
    describe "when called on the Attribute subclass #{klass}" do
      subject { klass.new(:id) }

      it { should be_kind_of(Attribute) }

      it { should be_kind_of(klass) }
    end
  end
end
