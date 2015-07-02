module CoordinateCheck
  BOARD_WIDTH = 8
  BOARD_HEIGHT = 8

  def valid_coord?(coordinate)
    ('a'..'z').to_a[0...BOARD_WIDTH].include?(coordinate[0]) && ('1'..'26').to_a[0...BOARD_HEIGHT].include?(coordinate[1..-1])
  end

end