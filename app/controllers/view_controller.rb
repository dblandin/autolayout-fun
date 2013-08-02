class ViewController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    top    = v('#5BB69A')
    subtop = v('#6BC36F')
    bottom = v('#4C9BD8')

    view << top << subtop << bottom

    views_dict = { 'top' => top, 'subtop' => subtop, 'bottom' => bottom }

    subleft   = v('#8F67B5')
    submiddle = v('#98A4A5')
    subright  = v('#D9823A')

    subtop << subleft << submiddle << subright

    subtop_dict = { 'left' => subleft, 'center' => submiddle, 'right' => subright }

    subtop.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'H:|-2-[left]-5-[center]-5-[right]-2-|',
      options: 0,
      metrics: nil,
      views: subtop_dict))

    subtop.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|-2-[left]-2-|',
      options: 0,
      metrics: nil,
      views: subtop_dict))

    subtop.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|-2-[center]-2-|',
      options: 0,
      metrics: nil,
      views: subtop_dict))

    subtop.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|-2-[right]-2-|',
      options: 0,
      metrics: nil,
      views: subtop_dict))

    subtop.addConstraint(NSLayoutConstraint.constraintWithItem(
      submiddle,
      attribute: NSLayoutAttributeWidth,
      relatedBy: NSLayoutRelationEqual,
      toItem: subleft,
      attribute: NSLayoutAttributeWidth,
      multiplier: 1.0,
      constant: 1.0))

    subtop.addConstraint(NSLayoutConstraint.constraintWithItem(
      subright,
      attribute: NSLayoutAttributeWidth,
      relatedBy: NSLayoutRelationEqual,
      toItem: subleft,
      attribute: NSLayoutAttributeWidth,
      multiplier: 1.0,
      constant: 1.0))

    view.addConstraint(NSLayoutConstraint.constraintWithItem(
      subright,
      attribute: NSLayoutAttributeCenterY,
      relatedBy: NSLayoutRelationEqual,
      toItem: subleft,
      attribute: NSLayoutAttributeCenterY,
      multiplier: 1.0,
      constant: 0))

    view.addConstraint(NSLayoutConstraint.constraintWithItem(
      submiddle,
      attribute: NSLayoutAttributeCenterY,
      relatedBy: NSLayoutRelationEqual,
      toItem: subleft,
      attribute: NSLayoutAttributeCenterY,
      multiplier: 1.0,
      constant: 0))

    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'H:|[top]|',
      options: 0,
      metrics: nil,
      views: views_dict))

    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'H:|[subtop]|',
      options: 0,
      metrics: nil,
      views: views_dict))

    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'H:|[bottom]|',
      options: 0,
      metrics: nil,
      views: views_dict))

    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      'V:|[top(100@1000)][subtop(50@1000)][bottom]|',
      options: 0,
      metrics: nil,
      views: views_dict))
  end

  def v(hex)
    UIView.alloc.init.tap do |top|
      top.translatesAutoresizingMaskIntoConstraints = false
      top.backgroundColor = hex.to_color
    end
  end
end
