class Time
  def pred
    self - 1
  end unless method_defined? :pred
end
