class OrganizationsController < ApplicationController
	verify :params => [:organization],
	    :render => {:action => "new"},
	    :add_flash => {
		    :error => "Organization record is required"
	    },
	    :only => :create # Run only for the "create" action
	verify :params => [:organization],
	    :render => {:action => "edit"},
	    :add_flash => {
		    :error => "Organization record is required"
	    },
	    :only => :update # Run only for the "update" action
	verify :params => [:id], :render => {:action => "index"}, :add_flash => {:error => "Missing organization id"}, :only => [:show, :edit, :update, :destroy]
	before_filter :find_id, :only => [:show, :edit, :update, :destroy]


	# GET /organizations
	# GET /organizations.xml
	def index
		@organizations = Organization.all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @organizations }
		end
	end

	# GET /organizations/1
	# GET /organizations/1.xml
	def show
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @organization }
		end
	end

	# GET /organizations/new
	# GET /organizations/new.xml
	def new
		@organization = Organization.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @organization }
		end
	end

	# GET /organizations/1/edit
	def edit
	end

	# POST /organizations
	# POST /organizations.xml
	def create
		@organization = Organization.new(params[:organization])

		respond_to do |format|
			if @organization.save
				format.html { redirect_to(@organization, :notice => 'Organization was successfully created.') }
				format.xml  { render :xml => @organization, :status => :created, :location => @organization }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /organizations/1
	# PUT /organizations/1.xml
	def update
		respond_to do |format|
			if @organization.update_attributes(params[:organization])
				format.html { redirect_to(@organization, :notice => 'Organization was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /organizations/1
	# DELETE /organizations/1.xml
	def destroy
		@organization = Organization.find(params[:id])
		@organization.destroy

		respond_to do |format|
			format.html { redirect_to(organizations_url) }
			format.xml  { head :ok }
		end
	end

	private def find_id

    if (Organization.exists?(params[:id]))
	    @organization = Organization.find(params[:id])
    else
	    flash['alert'] = "No organization found for that id: " + params[:id]
	    logger.debug "In OrganizationController. params[:id] not found: " + params[:id]
	    redirect_to :action => "index"
    end

end
end
