require 'bundler'
Bundler.require
require_relative '../lib/app/board_case'
require_relative '../lib/app/board'
require_relative'../lib/app/player'
require_relative '../lib/app/show'
require_relative '../lib/app/game'
require_relative '../lib/app/application'

require 'stringio'

RSpec.describe BoardCase do
  subject { described_class.new('B2') }

  describe '#initialize' do
    it 'sets the label correctly' do
      expect(subject.label).to eq('B2')
    end

    it 'initializes with empty value' do
      expect(subject.value).to eq(' ')
    end
  end

  describe '#occupied?' do
    context 'when value is empty' do
      it 'returns false' do
        expect(subject.occupied?).to be false
      end
    end

    context 'when value is set to X' do
      before { subject.value = 'X' }

      it 'returns true' do
        expect(subject.occupied?).to be true
      end
    end
  end

  describe '#to_s' do
    it 'returns the cell value as string' do
      subject.value = 'O'
      expect(subject.to_s).to eq('O')
    end
  end
end

RSpec.describe Board do
  let(:board) { described_class.new }

  describe '#initialize' do
    it 'creates 9 board cases' do
      expect(board.cells.size).to eq(9)
    end

    it 'labels all positions correctly' do
      labels = Board::POSITIONS
      expect(board.cells.map(&:label)).to match_array(labels)
    end
  end

  describe '#cell' do
    it 'returns the correct BoardCase by label (case-insensitive)' do
      c = board.cell('a1')
      expect(c).to be_a(BoardCase)
      expect(c.label).to eq('A1')
    end

    it 'returns nil for invalid label' do
      expect(board.cell('Z9')).to be_nil
    end
  end

  describe '#full?' do
    context 'when no moves have been made' do
      it 'returns false' do
        expect(board.full?).to be false
      end
    end

    context 'when all cells are occupied' do
      before do
        board.cells.each { |c| c.value = 'X' }
      end

      it 'returns true' do
        expect(board.full?).to be true
      end
    end
  end

  describe '#winner?' do
    context 'when a winning line is completed' do
      it 'detects horizontal win for X' do
        %w[A1 A2 A3].each { |pos| board.cell(pos).value = 'X' }
        expect(board.winner?('X')).to be true
      end

      it 'detects vertical win for O' do
        %w[A1 B1 C1].each { |pos| board.cell(pos).value = 'O' }
        expect(board.winner?('O')).to be true
      end

      it 'detects diagonal win' do
        %w[A1 B2 C3].each { |pos| board.cell(pos).value = 'X' }
        expect(board.winner?('X')).to be true
      end
    end

    context 'when no winning line is present' do
      it 'returns false' do
        board.cell('A1').value = 'O'
        board.cell('B2').value = 'X'
        board.cell('C3').value = 'O'
        expect(board.winner?('O')).to be false
      end
    end
  end

  describe '#render' do
    it 'returns a formatted string of the board' do
      board.cell('A1').value = 'X'
      rendered = board.render
      expect(rendered).to include('X |   |  ')
      expect(rendered).to include('---------')
    end
  end
end

RSpec.describe Player do
  subject { described_class.new('Alice', 'X') }

  describe '#initialize' do
    it 'sets name and symbol' do
      expect(subject.name).to eq('Alice')
      expect(subject.symbol).to eq('X')
    end
  end
end

RSpec.describe Game do
  let(:p1) { Player.new('Alice', 'X') }
  let(:p2) { Player.new('Bob', 'O') }
  subject { described_class.new(p1, p2) }

  describe '#switch_player' do
    it 'switches from first to second player' do
      subject.instance_variable_set(:@current_player, p1)
      subject.switch_player
      expect(subject.current_player).to eq(p2)
    end

    it 'switches back to first player' do
      subject.instance_variable_set(:@current_player, p2)
      subject.switch_player
      expect(subject.current_player).to eq(p1)
    end
  end

  describe '#play' do
    it 'déclare un gagnant quand le plateau est gagné' do
      # 1) stub full? pour continuer la boucle
      allow(subject.board).to receive(:full?).and_return(false)

      # 2) stub winner?: false puis true
      allow(subject.board)
        .to receive(:winner?)
        .with('X')
        .and_return(false, true)

      # 3) stub les affichages et l’entrée utilisateur
      allow(Show).to receive(:display_board)
      allow(Show).to receive(:prompt_move)
      allow(Show).to receive(:game_won)
      allow(subject).to receive(:gets).and_return("A1\n")

      # 4) forcer current_player à p1 (X)
      subject.instance_variable_set(:@current_player, p1)

      subject.play

      expect(Show).to have_received(:game_won).with(p1)
    end
  end
end