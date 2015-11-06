class String
  def is_part_of_bun?
    return true if self.strip.match(/\A\d+\z/) # Number = true
    return true if [',', '.'].include?(self.to_s)
    !self.ascii_only?
  end
end
