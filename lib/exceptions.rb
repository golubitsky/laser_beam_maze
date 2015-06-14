class ZeroDimensionMazeError < RuntimeError
  def message
    "ZeroDimensionMazeError: unable to build maze when either dimension is 0. Exiting."
  end
end

class FileNamesMissingError < RuntimeError
  def message
    "FileNamesMissingError: specify input (1st arg) output (2nd arg) filenames in the following format: ./relative/path/to/file"
  end
end

class InputFileMissingError < RuntimeError
  def message
    "InputFileMissingError: cannot read from file specified. Please check the path."
  end
end

class OutputDirectoryError < RuntimeError
  def message
    "OutputDirectoryError: Output directory does not exist. Please check the path."
  end
end
