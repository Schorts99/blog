class Admin::CommentsController < Admin::ApplicationController
  before_action :verify_logged_in
  
  def destroy
  end
end
