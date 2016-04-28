require 'rails_helper'

RSpec.describe Comment do
  def flag_assoc
    described_class.reflect_on_association(:flag)
  end
  def user_assoc
    described_class.reflect_on_association(:user)
  end

  it 'associates flags to comments' do
    expect(flag_assoc).to_not be_nil
    expect(flag_assoc.name).to eq(:flag)
  end

  it 'associates users to comments' do
    expect(user_assoc).to_not be_nil
    expect(user_assoc.name).to eq(:user)
  end

  it 'sets inverse_of record' do
    expect(flag_assoc.options[:inverse_of]).to_not be_nil
    expect(flag_assoc.options[:inverse_of]).to eq(:comments)
    expect(user_assoc.options[:inverse_of]).to_not be_nil
    expect(user_assoc.options[:inverse_of]).to eq(:comments)
  end

  it 'validates presence of comment content' do
    expect(Comment.create(content: 'Dummy content')).to be_valid
    expect(Comment.create).to be_invalid
  end
end
