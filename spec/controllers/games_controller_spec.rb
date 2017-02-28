require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'create action' do
    it 'creates a new game with a white player as the current user, and redirect to games' do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, game: { name: 'example game' }

      expect(Game.first.white_user).to eq user
      expect(response).to redirect_to(game_path(Game.first))
    end
  end

  describe 'update action' do
    it 'adds a player to empty black player slot and redirects to the game' do
      white_user = FactoryGirl.create(:user)
      sign_in white_user

      game = FactoryGirl.create(:game, id: 1, white_user_id: 1)

      black_user = FactoryGirl.create(:user, id: 2)
      sign_in black_user

      patch :update, id: game.id,
      game: {black_user_id: 2}

      expect(response).to redirect_to game_path(game)
    end
  end
end
