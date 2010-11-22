require 'spec_helper'

[ :union, :| ].each do |method|
  describe "Veritas::Algebra::Rename::Aliases##{method}" do
    subject { object.send(method, other) }

    let(:klass)     { Algebra::Rename::Aliases                     }
    let(:attribute) { Attribute::Integer.new(:id)                  }
    let(:aliases)   { { attribute => attribute.rename(:other_id) } }
    let(:object)    { klass.new(aliases)                           }

    context 'when other is empty' do
      let(:other) { {} }

      it { should be_kind_of(klass) }

      it 'does nothing' do
        should == object
      end
    end

    context 'when other contains duplicate attributes' do
      let(:other) { klass.new(attribute => attribute.rename(:another_id)) }

      it { should be_kind_of(klass) }

      it 'ignores duplicate attributes' do
        should == klass.new(attribute => attribute.rename(:other_id))
      end
    end

    context 'when other contains new attributes' do
      let(:other_attribute) { Attribute::String.new(:name) }
      let(:other)           { klass.new(other_attribute => other_attribute.rename(:other_name)) }

      it { should be_kind_of(klass) }

      it 'allows new attributes' do
        should == klass.new(attribute => attribute.rename(:other_id), other_attribute => other_attribute.rename(:other_name))
      end
    end

    context 'when other has an original attribute that is renamed to a different name' do
      let(:other_attribute) { Attribute::Integer.new(:original_id) }
      let(:other)           { klass.new(other_attribute => other_attribute.rename(:id)) }

      it { should be_kind_of(klass) }

      it 'simplifies the rename' do
        should == klass.new(other_attribute => attribute.rename(:other_id))
      end
    end

    context 'when other has an original attribute that is renamed to the same name' do
      let(:other_attribute) { Attribute::Integer.new(:other_id) }
      let(:other)           { klass.new(other_attribute => other_attribute.rename(:id)) }

      it { should be_kind_of(klass) }

      it 'eliminates the name' do
        should == klass.new({})
      end
    end
  end
end
