require 'spec_helper'

describe Algebra::Rename::Aliases, '#each' do
  subject { object.each { |old_attr, new_attr| yields << [ old_attr, new_attr ] } }

  let(:klass)     { Algebra::Rename::Aliases                     }
  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:aliases)   { { attribute => attribute.rename(:other_id) } }
  let(:object)    { klass.new(aliases)                           }
  let(:yields)    { []                                           }

  it_should_behave_like 'a command method'

  it 'yields each alias' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to(aliases.to_a)
  end
end
