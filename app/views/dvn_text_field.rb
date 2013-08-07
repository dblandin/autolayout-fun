class DVNTextField < UITextView
  def initWithFrame(frame)
    super

    self.contentInset       = UIEdgeInsetsMake(10, 10, 10, 10)
    self.font               = UIFont.fontWithName('HelveticaNeue', size: 18.0)
    self.layer.cornerRadius = 10.0
    self.returnKeyType      = UIReturnKeyDone
    self.textColor          = UIColor.grayColor

    self
  end
end
