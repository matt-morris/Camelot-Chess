require 'rails_helper'

RSpec.describe Bishop, type: :model do
  let(:game) do
  Game.create(
    white_user: FactoryGirl.create(:user),
    black_user: FactoryGirl.create(:user))
  end

  def create_game_with_bishop
    Bishop.create(color: true, x_position: 4, y_position: 4, game: game)
  end

  describe 'valid_move?' do
    context 'unobstructed moves' do
      it 'returns false if moves vertically' do
        game.pieces.delete_all
        bishop = create_game_with_bishop
        expect(bishop.valid_move?(4,6)).to eq false
      end

      it 'returns false if moves horizontally' do
        game.pieces.delete_all
        bishop = create_game_with_bishop
        expect(bishop.valid_move?(1,4)).to eq false
      end

      it 'returns true if moving diagonally' do
        game.pieces.delete_all
        bishop = create_game_with_bishop
        expect(bishop.valid_move?(7,7)).to eq true
      end

      it 'returns false if it moves off the board' do
        game.pieces.delete_all
        bishop = create_game_with_bishop
        expect(bishop.valid_move?(200,15)).to eq false
      end
    end
    context 'obstructed moves' do
      it 'returns false if move is blocked when moving left and down?' do
        game.pieces.delete_all
        bishop = Bishop.create(color: true, x_position: 7, y_position: 7, game: game)
        pawn = Pawn.create(color: true, x_position: 4, y_position: 4, game: game)

        expect(bishop.valid_move?(0,0)).to eq false
      end

      it 'returns false if move is blocked when moving right and up?' do
        game.pieces.delete_all
        bishop = Bishop.create(color: true, x_position: 0, y_position: 0, game: game)
        pawn = Pawn.create(color: true, x_position: 4, y_position: 4, game: game)

        expect(bishop.valid_move?(7,7)).to eq false
      end
    end
  end
end
