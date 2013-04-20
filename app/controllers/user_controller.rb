class UserController < ApplicationController
  before_filter :init
  def init
    @MENU[:home][:active] = true
  end

  def index
  end

  def auth
    if params[:name] then
      begin
        u= Person.find params[:name]
        if u.auth params[:password] then
          session[:user_id]= u.id
          redirect_to :action => "index"
        else
          @error = "Username oder Passwort ist falsch"
        end
      rescue ActiveLdap::EntryNotFound
        @error = "Username oder Passwort ist falsch"
      end
    end
    if params[:out] then
      reset_session
      redirect_to :action => 'auth'
    end
  end

end
