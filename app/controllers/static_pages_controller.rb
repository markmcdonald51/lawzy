class StaticPagesController < ApplicationController

  #skip_before_filter :check_user_data, only: [:home]
  skip_before_filter :signed_in?, only: [:home]
  def home
    #@rec_reports = Report.where(recommended: true).order('actual_post_date DESC').take(3)

    # use this variable on home page (instead of @rec_reports) and use that partial
    # while there are no reports marked as recommended
    #@reports = Report.all.order('actual_post_date DESC').take(4)
  end

  def about
  end
end
