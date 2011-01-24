class PeopleController < ApplicationController
    verify :params => [:person], :render => {:action => :new}, 
    :add_flash => {:error => "Person record must be given"},
        :only => :create
    verify :params => [:person], :render => {:action => :edit},
        :add_flash => {:error => "Person record must be given"},
        :only => :update
    verify :params => [:id], :render => {:action => :index},
        :add_flash => {:error => "No valid person selected"}, :only => [:show, :edit, :update, :destroy]
    before_filter :find_id, :only => [:show, :edit, :update, :destroy]
    
	# GET /people
	# GET /people.xml
	def index
		@people = Person.all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @people }
		end
	end

	# GET /people/1
	# GET /people/1.xml
	def show
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @person }
		end
	end

	# GET /people/new
	# GET /people/new.xml
	def new
		@person = Person.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @person }
		end
	end

	# GET /people/1/edit
	def edit
	end

	# POST /people
	# POST /people.xml
	def create
		@person = Person.new(params[:person])

		respond_to do |format|
			if @person.save
				format.html { redirect_to(@person, :notice => 'Person was successfully created.') }
				format.xml  { render :xml => @person, :status => :created, :location => @person }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /people/1
	# PUT /people/1.xml
	def update

		respond_to do |format|
			if @person.update_attributes(params[:person])
				format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /people/1
	# DELETE /people/1.xml
	def destroy
		@person.destroy

		respond_to do |format|
			format.html { redirect_to(people_url) }
			format.xml  { head :ok }
		end
	end
	
	private
	def find_id
        if (Person.exists?(params[:id]))
		    @person = Person.find(params[:id])
		else
		    logger.debug "In Person.find_id. params[:id] not found in database: " + params[:id]
		    flash['alert'] = "No person found with that identifier" + params[:id]
		    redirect_to :action => 'index'
	    end

	end
end
