#Rendering 3 ways
#using render to render complete pages

render :nothing => true

def update
	@book = Book.find(params[:id])
		if @book.update_attributes(params[:block])
			redirect_to(@book)
		else
			#or use render :action => "edit"
			render "edit" #renders edit.html.erb or render :edit
		end		
	end
end

#if rendering actions template from diff controller

render 'products/show'
#or 
render :template => 'products/show'
#aarbitrary file
render 'path_to_file'
#or
render :file => "path_to_file"

#if rails need to put in current layout 
:layout => true

#Inline
render :inline => "<% products.each do |p| %><p><%= p.name%></p><% end %>"

#plaint text
render :text => "OK"
#Rendering JSON, xml

render :json => @products
render :xml => @products

'''options to render

    :content_type -- application/json, application/xml, rss
    :layout -- false, 'special_layout', 
    :status -- 500, forbidden, 
    :location
'''

#2nd way using redirect_to

redirect_to photos_path #same parameters as link_for
redirect_to :back #previous page

 #302 is the HTTP status code  when redirect_to called
redirect_to photos_path, :status => 301 #changes he code

#using head

head :bad_request
head :created

