require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::LessThan }

  it { should be(:<) }
end
