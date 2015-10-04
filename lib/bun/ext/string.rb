class String
  def is_part_of_bun?
    return true if self.match(/\A\d+\z/)
    return true if [','].include?(self.to_s)
    !self.ascii_only?
  end
end
