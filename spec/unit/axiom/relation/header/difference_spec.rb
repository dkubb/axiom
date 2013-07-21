# encoding: utf-8

require 'spec_helper'

[:difference, :-].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, other) }

    let(:object)           { described_class.coerce(attributes, options)             }
    let(:other)            { described_class.coerce(other_attributes, other_options) }
    let(:attributes)       { [[:id, Integer], [:name, String]]                       }
    let(:other_attributes) { attributes                                              }
    let(:options)          { {}                                                      }
    let(:other_options)    { options                                                 }
    let(:keys)             { Relation::Keys.coerce([[[:id, Integer]]])               }
    let(:other_keys)       { keys                                                    }

    context 'when the attributes are equivalent' do
      it { should be_instance_of(described_class) }

      its(:to_ary) { should be_empty }

      its(:keys) { should be_empty }
    end

    context 'when the attributes intersect' do
      let(:other_attributes) { [[:id, Integer]] }

      it { should be_instance_of(described_class) }

      its(:to_ary) { should == [[:name, String]] }

      its(:keys) { should be_empty }
    end

    context 'when the attributes do not intersect' do
      let(:other_attributes) { [[:age, Integer]] }

      it { should be_instance_of(described_class) }

      its(:to_ary) { should == [[:id, Integer], [:name, String]] }

      its(:keys) { should be_empty }
    end

    context 'when the keys are equivalent' do
      let(:other_attributes) { [[:id, Integer], [:name, String], [:age, Integer]] }
      let(:options)          { { keys: keys }                                     }

      it { should be_instance_of(described_class) }

      its(:to_ary) { should be_empty }

      its(:keys) { should be_empty }
    end

    context 'when the keys intersect' do
      let(:other_attributes) { [[:id, Integer], [:name, String], [:age, Integer]] }
      let(:options)          { { keys: keys }                                     }
      let(:other_options)    { { keys: other_keys }                               }

      let(:other_keys) do
        Relation::Keys.coerce([
          [[:id,  Integer]],
          [[:age, Integer]],
        ])
      end

      it { should be_instance_of(described_class) }

      its(:to_ary) { should be_empty }

      its(:keys) { should be_empty }
    end

    context 'when the keys do not intersect' do
      let(:other_attributes) { [[:id, Integer], [:name, String], [:age, Integer]] }
      let(:options)          { { keys: keys }                                     }
      let(:other_options)    { { keys: other_keys }                               }

      let(:other_keys) do
        Relation::Keys.coerce([[[:name, String], [:age, Integer]]])
      end

      it { should be_instance_of(described_class) }

      its(:to_ary) { should be_empty }

      its(:keys) { should eql(keys) }
    end

    context 'when the other can be coerced into a Header' do
      let(:other) { other_attributes }

      its(:to_ary) { should be_empty }

      its(:keys) { should be_empty }
    end
  end
end
