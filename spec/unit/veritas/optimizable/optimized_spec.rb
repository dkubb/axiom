require 'spec_helper'

describe 'Veritas::Optimizable#optimized?' do
  subject { optimizable.optimized? }

  let(:klass)       { Class.new { include Optimizable } }
  let(:optimizable) { klass.new                         }

  it { should be(true) }
end
