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

  end

end
