class UserController < ApplicationController
  before_filter :init
  def init
    @MENU[:home][:active] = true
  end

  def index
    @user = @USER
    if params[:new] then
      @hide_data = true
      if params[:new] != params[:new2] then
        @error = "Die Passwort wiederholung ist falsch!"
      elsif !@user.auth params[:old] then
        @error = "Dein bisheriges Password ist falsch!"
      else
        @user.auth= params[:new]
        @user.save
        @hide_data = false
      end
    end
  end

  def auth
    @MENU[:home][:active] = false
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
  end

  def logout
    reset_session
    redirect_to :action => 'auth'
  end
end
