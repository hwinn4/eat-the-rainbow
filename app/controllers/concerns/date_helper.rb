module DateHelper
  def string_to_date(date_string)
    DateTime.parse(date_string)
  end

  def date_to_string(date)
    date.strftime('%m/%d/%Y')
  end
end