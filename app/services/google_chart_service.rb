class GoogleChartService
  # Render Pie Chart
  def self.render_pie_chart(options = {})
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', options[:col_x])
    data_table.new_column('number', options[:col_y])
    data_table.add_rows(options[:data_for_chart])

    if options[:required_formatter]
      formatter = GoogleVisualr::ArrowFormat.new
      formatter.columns(1)
      data_table.format(formatter)
    end
    opts = { :title => options[:chart_name], :legend => 'bottom' }
    options[:chart_type] == :bar
      if !options[:interactive].present?
        chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
      else
        chart = GoogleVisualr::Image::BarChart.new(data_table, opts)
      end
    chart
  end
end