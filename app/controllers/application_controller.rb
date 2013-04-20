class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_applivation
  def init_applivation
    @MENU = {:home =>{
        :text => "Home",
        :controller => "user",
        :action => "index"
       },
       :people =>{
        :text => "Personen",
        :controller => "people",
        :action => "index"
       },
       :groups =>{
        :text => "Gruppen",
        :controller => "groups",
        :action => "index"
       },
       :departments =>{
        :text => "Abteilungen",
        :controller => "departments",
        :action => "index"
       }
    }

    if ((controller_name != 'user') or (action_name != 'auth')) and session[:user_id].nil? then
      redirect_to :controller => "user", :action => "auth"
    end
    @USER_LOGIN = !session[:user_id].nil?
  end

end
