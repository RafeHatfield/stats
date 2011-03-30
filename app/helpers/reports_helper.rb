module ReportsHelper
  def prepare_data(data, start_date, end_date)
    days = []
    start_date.upto(end_date) do |date|
      year = date.year
      month = date.month - 1
      day = date.day
      days << "Date.UTC(#{year}, #{month}, #{day})"
    end
    results = days.zip(data).to_json
  end
end
