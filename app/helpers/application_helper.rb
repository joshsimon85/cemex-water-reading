module ApplicationHelper
  def format_time(date_time)
    date_time.strftime('%I:%M %p')
  end

  def format_date(date_time)
    date_time.strftime('%A, %B %d, %Y')
  end
end
