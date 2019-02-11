class DemoController < ApplicationController
  layout "application"

  def index
    render("index")
  end

  def escape_output
  end
end
