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
        :text => "Benutzer",
        :controller => "people",
        :action => "index"
       },
       :groups =>{
        :text => "Gruppen",
        :controller => "groups",
        :action => "index",
        :hidden => true
       },
       :departments =>{
        :text => "Abteilungen",
        :controller => "departments",
        :action => "index",
        :hidden => true
       }
    }

    if ((controller_name != 'user') or ((action_name != 'auth') and (action_name != 'token'))) and session[:user_id].nil? then
      redirect_to :controller => "user", :action => "auth"
    end
    if !session[:user_id].nil? then
      @USER_LOGIN = true
      @USER = Person.find session[:user_id]
      if @USER.member? 'ldapadmin' then
        @MENU[:groups][:hidden] = false
        @MENU[:departments][:hidden] = false
      end
    end
  end

end
