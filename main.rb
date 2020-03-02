require 'ruby2d'

# Program Setup
FILES = ["a", "b", "c", "d", "e", "f", "g", "h"]

class ChessSquare
    def initialize()
        @file = 0
        @rank = 0
        @name = ""
        @color = 0
    end

    def newSquare
        @file = rand(8)
        @rank = rand(8) + 1
        @name = FILES[@file] + @rank.to_s
    end

    def checkAnswer(answerColor)
        squareValue = @file + 1 + @rank
        answer = ""

        squareValue % 2 != 0 ? answer = "white" : answer = "black"
        if answerColor == answer
            puts "Correct: " + @name + " is " + answerColor
        else 
            puts "Incorrect: " + @name + " is " + answer
        end
    end
end

chessSquare = ChessSquare.new

# Window Setup
set title: "Chess Square Color Visualization", background: "#f5f2d0"

# Object Setup
squareText = Text.new(
    chessSquare.newSquare,
    size: 64,
    x: 288, y: 208,
    color: "black"    
)

class Button 
    def initialize(x, y, w, h, stroke_color, fill_color)
        @outerRect = Rectangle.new(x: x, y: y, width: w, height: h, color: stroke_color)
        @innerRect = Rectangle.new(x: x + 1, y: y + 1, width: w - 2, height: h - 2, color: fill_color)
    end

    def contains(x, y)
        @outerRect.contains? x, y
    end
end

whiteButton = Button.new(64, 208, 64, 64, "black", "white")
blackButton = Button.new(512, 208, 64, 64, "black", "black")

# Program Start
on :mouse_up do |event|
    if event.button == :left
        if whiteButton.contains(Window.mouse_x, Window.mouse_y)
            chessSquare.checkAnswer("white")
            squareText.text=(chessSquare.newSquare)
        elsif blackButton.contains(Window.mouse_x, Window.mouse_y)
            chessSquare.checkAnswer("black")
            squareText.text=(chessSquare.newSquare)
        end
    end
end

show