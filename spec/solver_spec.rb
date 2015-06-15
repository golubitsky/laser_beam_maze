require 'securerandom'

def random_file_name
  ('./' + SecureRandom.base64).gsub(/\W/, '')
end

describe "Solving of valid maze" do
  context "without loop" do
    before(:all) do
      input = './spec/test_mazes/basic.txt'
      @output = random_file_name
      LaserMaze::Solver.new(input, @output).run
      @output_file = File.readlines(@output)
    end

    after(:all) do
      File.delete(@output)
    end

    it "yields a file having two lines" do
      expect(@output_file.length).to be(2)
    end

    it "determines and outputs correct number of squares traversed by beam" do
      expect(@output_file[0]).to eq("9\n")
    end

    it "determines and outputs correct final coordinate of beam" do
      expect(@output_file[1]).to eq("0 0\n")
    end
  end

  context "positioned next to and facing a wall" do
    before(:all) do
      input = './spec/test_mazes/at_wall.txt'
      @output = random_file_name
      LaserMaze::Solver.new(input, @output).run
      @output_file = File.readlines(@output)
    end

    after(:all) do
      File.delete(@output)
    end

    it "yields a file having two lines" do
      expect(@output_file.length).to be(2)
    end

    it "determines and outputs correct number of squares traversed by beam" do
      expect(@output_file[0]).to eq("0\n")
    end

    it "determines and outputs correct final coordinate of beam" do
      expect(@output_file[1]).to eq("654 999\n")
    end
  end

  context "starting in a loop" do
    before(:all) do
      @output_file_strings = []
      2.times do |n|
        input = "./spec/test_mazes/loop_#{n}.txt"
        @output_file_strings << random_file_name
        LaserMaze::Solver.new(input, @output_file_strings.last).run
      end
    end

    after(:all) do
      @output_file_strings.each do |str|
        File.delete(str)
      end
    end

    it "yields a file having one line" do
      @output_file_strings.each do |str|
        file = File.readlines(str)
        expect(file.length).to be(1)
      end
    end

    it "determines and outputs correct number of squares traversed by beam" do
      @output_file_strings.each do |str|
        file = File.readlines(str)
        expect(file.first).to eq("-1\n")
      end
    end
  end
end
