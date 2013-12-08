class PeopleController < ApplicationController
  before_filter :ensure_login, :only => [:edit, :update, :destroy]
  before_filter :ensure_logout, :only => [:new, :create]

  def index
    @people = Person.find(:all)
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(parms[:person])
    if @person.save
      @session = @person.session.create
      session[:id] = @session.id
      flash[:notice] = "Welcome #{@person.name}, you are now registered"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
