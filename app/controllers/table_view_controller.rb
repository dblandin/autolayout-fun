class TableViewController < UIViewController
  def viewDidLoad
    super

    table_view.registerClass(ExpandableCell, forCellReuseIdentifier: 'CELL')

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews 'table' => table_view
      layout.horizontal '|[table]|'
      layout.vertical '|[table]|'
    end
  end

  def dummy_cell
    @dummy_cell ||= ExpandableCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: 'CELL')
  end

  def table_view
    @table_view ||= UITableView.alloc.init.tap do |table|
      table.dataSource = self
      table.delegate   = self
    end
  end

  def tableView(table_view, numberOfRowsInSection: section)
    1
  end

  def tableView(table_view, numberOfRowsInSection: section)
    10
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    dummy_cell.text = random_text(index_path.row + 1)
    dummy_cell.calculated_height
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    cell = table_view.dequeueReusableCellWithIdentifier('CELL', forIndexPath: index_path)

    cell.text = random_text(index_path.row + 1)

    cell
  end

  def random_text(lines)
    lorems = []
    lines.times { lorems << lorem }
    lorems.join(' ')
  end

  def lorem
    'Swine doner fatback jerky pig ribeye, pork loin shoulder filet mignon tri-tip bacon bresaola hamburger kielbasa short loin.'
  end
end
