class ExpandableCell < UITableViewCell
  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super.tap do |cell|
      cell.setup_constraints
    end
  end

  def setup_constraints
    Motion::Layout.new do |layout|
      layout.view       contentView
      layout.subviews   'label' => label
      layout.horizontal '|[label]|'
      layout.vertical   '|[label]|'
    end
  end

  def text=(text)
    label.text = text
  end

  def calculated_height
    label_size = label.text.sizeWithFont(label.font, constrainedToSize: CGSizeMake(size.width, 480))
    label_size.height
  end

  def label
    @label ||= UILabel.alloc.init.tap do |label|
      label.numberOfLines = 0
    end
  end

  def layoutSubviews
    super
  end
end
