class InputController < UIViewController
  attr_reader :keyboard_height

  def viewDidLoad
    super

    view.backgroundColor = UIColor.grayColor

    setup_constraints

    observe_keyboard
  end

  def setup_constraints
    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews subviews_dict
      layout.vertical '[input(>=100@1000)]'
      layout.horizontal '|[input]|'
    end

    @keyboard_height = NSLayoutConstraint.constraintWithItem(
      input,
      attribute: NSLayoutAttributeBottom,
      relatedBy: NSLayoutRelationEqual,
      toItem: view,
      attribute: NSLayoutAttributeBottom,
      multiplier: 1.0,
      constant: 0.0)

    view.addConstraint(keyboard_height)
  end

  def subviews_dict
    { 'input' => input }
  end

  def observe_keyboard
    NSNotificationCenter.defaultCenter.addObserver(self, selector: 'keyboard_will_show:', name: UIKeyboardWillChangeFrameNotification, object: nil)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: 'keyboard_will_hide:', name: UIKeyboardWillHideNotification, object: nil)
  end

  def keyboard_will_show(notification)
    info = notification.userInfo
    kb_frame = info[UIKeyboardFrameEndUserInfoKey]
    animation_duration = info[UIKeyboardAnimationDurationUserInfoKey].doubleValue
    keyboard_frame = kb_frame.CGRectValue

    height = keyboard_frame.size.height

    keyboard_height.constant = -height

    UIView.animateWithDuration(animation_duration, animations: lambda { view.layoutIfNeeded })
  end

  def keyboard_will_hide(notification)
    info = notification.userInfo
    animation_duration = info[UIKeyboardAnimationDurationUserInfoKey].doubleValue

    keyboard_height.constant = 0
    UIView.animateWithDuration(animation_duration, animations: lambda { view.layoutIfNeeded })
  end

  def input
    @input ||= DVNTextField.alloc.init.tap do |text_view|
      text_view.delegate = self
    end
  end

  def textView(text_view, shouldChangeTextInRange: range, replacementText: text)
    if text == "\n"
      text_view.resignFirstResponder
      false
    else
      true
    end
  end
end
