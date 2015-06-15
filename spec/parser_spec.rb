describe "Parsing" do
  describe "of valid maze" do
    before(:all) do
      @maze = LaserMaze::Parser.build_maze('./spec/test_mazes/basic.txt')
    end

    specify "does not raise error" do
      expect{ @maze }.not_to raise_error
    end

    specify "width" do
      expect(@maze.width).to be(5)
    end

    specify "height" do
      expect(@maze.height).to be(6)
    end

    specify "starting direction" do
      expect(@maze.start_direction).to be(:S)
    end

    specify "mirrors" do
      expect(@maze.pos(3, 4)).to eq("/")
      expect(@maze.pos(3, 0)).to eq("/")
      expect(@maze.pos(1, 2)).to eq("\\")
      expect(@maze.pos(3, 2)).to eq("\\")
      expect(@maze.pos(4, 3)).to eq("\\")
    end

    specify "empty squares" do
      expect(@maze.pos(0, 0)).to eq(:empty)
      expect(@maze.pos(4, 5)).to eq(:empty)
    end
  end

  describe "of invalid maze" do
    before(:all) do
      @invalid = './spec/test_mazes/zero_dimension.txt'
    end

    specify "raises zero-dimension error" do
      expect{ LaserMaze::Parser.build_maze(@invalid) }.to raise_error(LaserMaze::ZeroDimensionMazeError)
    end
  end
end
