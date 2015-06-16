module LaserMaze
  class FileLoadError < RuntimeError
  end

  class FileNamesMissingError < FileLoadError
    def message
      "FileNamesMissingError: user must specify input and output files. Try \"./maze help\""
    end
  end

  class InputFileMissingError < FileLoadError
    def message
      "InputFileMissingError: please check the path. Try \"./maze help\""
    end
  end

  class OutputDirectoryError < FileLoadError
    def message
      "OutputDirectoryError: please check the path. Try \"./maze help\""
    end
  end

  class ZeroDimensionMazeError < RuntimeError
    def message
      "ZeroDimensionMazeError: unable to build maze when either dimension is 0. Exiting."
    end
  end
end
