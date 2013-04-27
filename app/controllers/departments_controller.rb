class DepartmentsController < ApplicationController
  before_filter :init
  def init
    @MENU[:departments][:active] = true
    redirect_to :controller => 'home', :action => '403' if !@USER.member? 'ldapadmin'
  end

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @departments }
    end
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @department }
    end
  end

  # GET /departments/1/attribute/sn
  def get_attribute
    person = Department.find(params[:id]);

    mime = "application/octet-stream"

    atr = person.must + person.may
    atr.each { |e|
      if e.name == params[:attribute] then
        case e.syntax.id
        when "1.3.6.1.4.1.1466.115.121.1.28"
          mime = "image/jpeg"
        end
      end
    }
    a = person.attributes[params[:attribute]]
    if a.kind_of?(Array) then a = a[0] end

    if a.nil?  then
      render :status => 404
    else
      send_data a, :type => mime
    end
  end

  # GET /departments/new
  # GET /departments/new.json
  def new
    @department = Department.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @department }
    end
  end

  # GET /departments/1/edit
  def edit
    @department = Department.find(params[:id])
  end

  # POST /departments
  # POST /departments.json
  def create
    if !params[:upload].nil? then
      params[:upload].each { |n,f|
        params[:department][n] = f.tempfile.read
      }
    end

    @department = Department.new(params[:department])

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render json: @department, status: :created, location: @department }
      else
        format.html { render action: "new" }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /departments/1
  # PUT /departments/1.json
  def update
    @department = Department.find(params[:id])

    if !params[:upload].nil? then
      params[:upload].each { |n,f|
        params[:department][n] = f.tempfile.read
      }
    end

    respond_to do |format|
      if @department.update_attributes(params[:department])
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    respond_to do |format|
      format.html { redirect_to departments_url }
      format.json { head :no_content }
    end
  end
end
