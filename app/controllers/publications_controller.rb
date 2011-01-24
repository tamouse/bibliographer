class PublicationsController < ApplicationController
	verify :params => [:publication],
	    :render => {:action => "new"},
	    :add_flash => {
		    :error => "Publication  is required"
	    },
	    :only => :create # Run only for the "create" action
	verify :params => [:publication],
	    :render => {:action => "edit"},
	    :add_flash => {
		    :error => "Publication  is required"
	    },
	    :only => :update # Run only for the "update" action
	verify :params => [:id], :render => {:action => "index"}, :add_flash => {:error => "No publication specified"}, :only => [:show, :edit, :update, :destroy]
	before_filter :find_id, :only => [:show, :edit, :update, :destroy]



	# GET /publications
	# GET /publications.xml
	def index
		@publications = Publication.all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @publications }
		end
	end

	# GET /publications/1
	# GET /publications/1.xml
	def show
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @publication }
		end
	end

	# GET /publications/new
	# GET /publications/new.xml
	def new
		@publication = Publication.new
        
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @publication }
		end
	end

	# GET /publications/1/edit
	def edit
	end

	# POST /publications
	# POST /publications.xml
	def create
		@publication = Publication.new(params[:publication])
        logger.debug "New publication: #{@publication.attributes.inspect}"
        logger.debug "publication should be valid: #{@publication.valid?}"
        logger.debug "Publication title: >>#{@publication.title}<<" 

		respond_to do |format|
			if (@publication.save)
			    @publication.add_authors(params[:authors][:list])
			    @publication.add_editors(params[:editors][:list])
			    @publication.add_tags(params[:tags][:list])
			    flash[:notice] = 'Publication was successfully created.'
                logger.debug "The publication was saved and now is the user is going to be redirected..."
                
				format.html { redirect_to(@publication, :notice => 'Publication was successfully created.') }
				format.xml  { render :xml => @publication, :status => :created, :location => @publication }
			else
			    flash[:notice] = 'Publication was NOT successfully created.'
                logger.debug "The publication was NOT saved and the script will render a new entry again..."
			    
				format.html { render :action => "new" }
				format.xml  { render :xml => @publication.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /publications/1
	# PUT /publications/1.xml
	def update
		respond_to do |format|
			if (@publication.update_attributes(params[:publication]) and @publication.update_authors(params[:authors]) \
			    and @publication.update_editors(params[:editors]) and @publication.update_tags(params[:tags]))
				format.html { redirect_to(@publication, :notice => 'Publication was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @publication.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /publications/1
	# DELETE /publications/1.xml
	def destroy
		@publication.destroy

		respond_to do |format|
			format.html { redirect_to(publications_url) }
			format.xml  { head :ok }
		end
	end
	
	private
	def find_id
	    if Publication.exists?(params[:id])
	        @publication = Publication.find(params[:id])
        else
            logger.debug "Invalid id given - not found in database: " + params[:id]
	        flash['alert'] = "No publication found with that id: " + params[:id]
	        redirect_to(:action => "index")
        end
	    logger.debug  "In PublicationsController.find_id."
	    logger.debug  "publication is #{@publication.inspect}"
    end
end
