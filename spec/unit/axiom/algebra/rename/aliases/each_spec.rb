# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename::Aliases, '#each' do
  subject { object.each { |old_attr, new_attr| yields << [ old_attr, new_attr ] } }

  let(:object)    { described_class.new(aliases)                 }
  let(:aliases)   { { attribute => attribute.rename(:other_id) } }
  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:yields)    { []                                           }

  it_should_behave_like 'an #each method'

  it 'yields each alias' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to(aliases.to_a)
  end
end
