class ZeroDimensionMazeError < RuntimeError
  def message
    "Error: unable to build maze when either dimension is 0. Exiting."
  end
end
