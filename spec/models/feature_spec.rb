require 'spec_helper'

describe Feature do
  before { @feature = FactoryGirl.build(:feature_with_bonus) }

  subject { @feature }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:duration) }

end
