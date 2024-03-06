require 'rails_helper'

RSpec.describe User do
    it { should have_many(:favorites) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password_digest) }
    #it { should validate_presence_of(:api_key) }
end