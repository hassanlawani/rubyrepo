sql = "SELECT * FROM table ORDER BY date DESC LIMIT 15;"

  # Execute the query
  results = db.query(sql,:as => :hash)
  ::LOGGER.info "results = '#{results}'"

  # Sending to List widget, so map to :label and :value
  hrows = [
    { cols: [ {value: 'Heading1'},
      {value: 'Heading2'},
      {value: 'Heading3'},
      {value: 'Heading4'}
    ] }
  ]
  ::LOGGER.debug "Table Headers #{hrows}"
  ary = Array.new
  results.each do |row|
    rows = { cols: [ {value: "#{row['column1']}"},
        {value: "#{row['column2']}"},
        {value: "#{row['column3']}"},
        {value: "#{row['column4']}"}
      ] }
    ary.push(rows)
    ::LOGGER.debug "Table Row #{rows}"
  end
  ::LOGGER.debug "Table Row #{ary}"
  send_event('mytable', { hrows: hrows, rows: ary } )
