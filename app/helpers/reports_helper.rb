module ReportsHelper
  def format_date(date)
    date.strftime('%d/%m/%Y')
  end
end
