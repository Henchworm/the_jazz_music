require 'spec_helper'
RSpec.describe Admin do
  describe 'validations' do
    it 'requires username' do
      admin_1 = Admin.new(username: nil, password: 'danger')
      expect(admin_1.save).to eq(false)
    end

    it 'requires password' do
      admin_1 = Admin.new(username: 'funbug', password: nil)
      expect(admin_1.save).to eq(false)
    end

    it 'has unique username' do
      admin_1 = Admin.create!(username: 'yodaleeheehoo!', password: 'danger')
      admin_2 = Admin.new(username: 'yodaleeheehoo!', password: 'danger')
      expect(admin_2.save).to eq(false)
    end

    it 'has secure password' do
      admin_1 = Admin.create!(username: 'yodaleeheehoo!', password: 'danger')
      expect(admin_1.password_digest).to_not eq('danger')
    end
  end
end
