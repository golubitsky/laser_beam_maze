module LaserMaze
  class ZeroDimensionMazeError < RuntimeError
    def message
      "ZeroDimensionMazeError: unable to build maze when either dimension is 0. Exiting."
    end
  end

  class FileLoadError < RuntimeError
  end
  class FileNamesMissingError < FileLoadError
    def message
      "FileNamesMissingError: specify input (1st arg) output (2nd arg) filenames in the following format: ./relative/path/to/file\nAlternatively use -g option to generate a random maze to the first filename provided. Caution: this will overwrite an existing file."
    end
  end

  class InputFileMissingError < FileLoadError
    def message
      "InputFileMissingError: cannot read from file specified. Please check the path.\nAlternatively use -g option to generate a random maze to the first filename provided. Caution: this will overwrite an existing file."
    end
  end

  class OutputDirectoryError < FileLoadError
    def message
      "OutputDirectoryError: Output directory does not exist. Please check the path."
    end
  end
end
