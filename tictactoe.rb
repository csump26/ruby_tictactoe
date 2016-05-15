module TicTacToe
	
	# List of possible winning combinations
	WINNING_COMB = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

	# Main class which drives the game
	class Game
		attr_reader :board, :current_player_id
		# Initialize the game with a new board 
		def initialize
			# Ignore index 0 for easier implementation
			@board = Array.new(10)
			@board.each_index do |i|
				@board[i] = i
			end
			# Set the current player has the first player to start the game
			@current_player_id = 0
		end

		# Public Methods 

		public
		 
		# Kicks off game
		def play
			# Ask for the player's name
			setup_players

			loop do
				player_select_position(current_player)

				if player_has_won?(current_player)
					puts "#{current_player.name} has won"
					display_board
					return
				elsif board_full?
					puts "It's a draw"
					display_board
					return
				end

				switch_players!
			end

		end

		# Private methods
		private
		# Asks the players for their name and determins who is X or O
		def setup_players

			player_one_name = String.new
			player_two_name = String.new
			
			while player_one_name.empty? do
				
				puts "Enter Player One's Name"
				player_one_name = gets.chomp
			end


			while player_two_name.empty? do
				
				puts "Enter Player Two's Name"
				player_two_name = gets.chomp
			end
			
			@players = [Player.new(player_one_name, "X"), Player.new(player_two_name, "O")]

			puts "-------------------------"
			puts "All players are set to go"

			puts "#{@players[0].name} is 'X' "
			puts "#{@players[1].name} is 'O' "


		end

		# Player selects available positions
		def player_select_position(player)
			display_board
			selection = 0
			loop do
				puts "#{player.name} select your position (1-9): "
				selection = gets.to_i
				break if free_positions.include?(selection)
				puts "Position #{selection} is not available. Please try again."
			end

			@board[selection] = player.marker
		end

		# Shows the current board
		def display_board
			puts "#{@board[1]} | #{@board[2]} | #{@board[3]} "
			puts "--+---+--"
			puts "#{@board[4]} | #{@board[5]} | #{@board[6]} "
			puts "--+---+--"
			puts "#{@board[7]} | #{@board[8]} | #{@board[9]} "
		
		end


		def current_player
			@players[current_player_id]
		end

		# Returns the positions that have not been selected by either players
		def free_positions
			(1..9).select {|position| @board[position].is_a? Integer}
		end


		def switch_players!
			@current_player_id = 1 - @current_player_id
		end

		def board_full?
			free_positions.empty?
		end

		# Checks if the player has selected any of the winning combinations
		def player_has_won?(player)
			WINNING_COMB.any? do |win|
				win.all? {|position| @board[position] == player.marker}
			end
		end
	end


	class Player
		attr_reader :name, :marker
		def initialize(name, marker)
			@name = name
			@marker = marker
		end
	end
end

include TicTacToe

ticTacToe = Game.new
ticTacToe.play