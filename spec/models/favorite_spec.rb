require 'rails_helper'

RSpec.describe Favorite do
    it { should belong_to(:user) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:recipe_link) }
    it { should validate_presence_of(:recipe_title) }
end