describe "Parsing" do
  subject(:maze) { LaserMaze::Parser.build_maze('./spec/test_mazes/basic.txt') }

  describe "of" do
    specify "width" do
      expect(maze.width).to be(5)
    end

    specify "height" do
      expect(maze.height).to be(6)
    end

    specify "starting direction" do
      expect(maze.start_direction).to be(:S)
    end

    specify "mirrors" do
      expect(maze.pos(3, 4)).to eq("/")
      expect(maze.pos(3, 0)).to eq("/")
      expect(maze.pos(1, 2)).to eq("\\")
      expect(maze.pos(3, 2)).to eq("\\")
      expect(maze.pos(4, 3)).to eq("\\")
    end

    specify "empty squares" do
      expect(maze.pos(0, 0)).to eq(:empty)
      expect(maze.pos(4, 5)).to eq(:empty)
    end
  end
end
