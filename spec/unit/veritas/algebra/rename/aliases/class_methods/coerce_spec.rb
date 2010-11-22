require 'spec_helper'

describe 'Veritas::Algebra::Rename::Aliases.coerce' do
  subject { object.coerce(attributes, aliases) }

  let(:attribute)  { Attribute::Integer.new(:id)         }
  let(:attributes) { Relation::Header.new([ attribute ]) }
  let(:object)     { Algebra::Rename::Aliases            }

  context 'the aliases are an Alias object' do
    let(:old_attr) { attribute                        }
    let(:new_attr) { attribute.rename(:other_id)      }
    let(:aliases)  { object.new(old_attr => new_attr) }

    it { should equal(aliases) }
  end

  context 'the old and new attributes are Symbols' do
    let(:old_attr) { :id                      }
    let(:new_attr) { :other_id                }
    let(:aliases)  { { old_attr => new_attr } }

    it { should be_kind_of(object) }

    it { should == { attribute => attribute.rename(:other_id) } }
  end

  context 'the old attribute is a Symbol, and the new attribute is an Attribute' do
    let(:old_attr) { :id                         }
    let(:new_attr) { attribute.rename(:other_id) }
    let(:aliases)  { { old_attr => new_attr }    }

    it { should be_kind_of(object) }

    it { should == { attribute => attribute.rename(:other_id) } }
  end

  context 'the old attribute is an Attribute, and the new attribute is a Symbol' do
    let(:old_attr) { attribute                }
    let(:new_attr) { :other_id                }
    let(:aliases)  { { old_attr => new_attr } }

    it { should be_kind_of(object) }

    it { should == { attribute => attribute.rename(:other_id) } }
  end

  context 'the old and new attributes are Attributes' do
    let(:old_attr) { attribute                   }
    let(:new_attr) { attribute.rename(:other_id) }
    let(:aliases)  { { old_attr => new_attr }    }

    it { should be_kind_of(object) }

    it { should == { attribute => attribute.rename(:other_id) } }
  end
end
