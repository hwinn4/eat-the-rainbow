module DateHelper
  def string_to_date(date_string)
    begin
      Date.strptime(date_string, '%m/%d/%Y')
    rescue
      Date.strptime(date_string, '%Y-%m-%d')
    end
  end

  def date_to_string(date)
    date.strftime('%m/%d/%Y')
  end
end