class ViewController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    top    = v('#5BB69A')
    subtop = v('#6BC36F')
    bottom = v('#4C9BD8')

    subleft   = v('#8F67B5')
    submiddle = v('#98A4A5')
    subright  = v('#D9823A')

    circle = v('#FF4632').tap do |circle|
      circle.layer.cornerRadius = 25.0
    end

    name = v('#0082BB')

    Motion::Layout.new do |layout|
      layout.view       subtop
      layout.subviews   'left' => subleft, 'center' => submiddle, 'right' => subright
      layout.vertical   '|-2-[left]-2-|'
      layout.vertical   '|-2-[center]-2-|'
      layout.vertical   '|-2-[right]-2-|'
      layout.horizontal '|-2-[left]-5-[center]-5-[right]-2-|'
    end

    Motion::Layout.new do |layout|
      layout.view top
      layout.subviews 'circle' => circle, 'name' => name
      layout.horizontal '|-[name]-[circle(50@500)]-|'
      layout.vertical '|-[circle(50@500)]'
      layout.vertical '|-[name(50@500)]'
    end

    Motion::Layout.new do |layout|
      layout.view       view
      layout.subviews   'top' => top, 'subtop' => subtop, 'bottom' => bottom
      layout.horizontal '|[top]|'
      layout.horizontal '|[subtop]|'
      layout.horizontal '|[bottom]|'
      layout.vertical   '|[top(100@1000)][subtop(50@1000)][bottom]|'
    end

    views_dict = { 'top' => top, 'subtop' => subtop, 'bottom' => bottom }

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
  end

  def v(hex)
    UIView.alloc.init.tap do |top|
      top.backgroundColor = hex.to_color
    end
  end
end
