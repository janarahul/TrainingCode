#Task of the form is to create model objects
#no _tag suffix (instance_variable, method(to call on the object))
<%= text_field(:person, :name)%> #<input id="person_name name="person[name]" type="text" value="person's name">

<% form_for :article, @article, url => { :action =>"create "} do |f|%>
	<%= f.text_field :title %>
	<%= f.text_area :body %>
<% end %>

#long way
form_for(:article, @article, :url => articles_path)
# same thing, short-style (record identification gets used if RESTful resources used):
form_for(@article)

#namespaces
form_for [:admin, @article]
#several level of namespaceng 
form_for [:admin, :management, @article]

#put and delete

<% form_for(search_path, :method => "put") %>
#select_tag

<select name="city_id" id="city_id">
  <option value="1">Lisbon</option>
  <option value="2">Madrid</option>
  ...
  <option value="12">Berlin</option>
</select>

#the above markup can be generated using

<%= select_tag(:city_id, '<option value="1">Lisbon</option>..') %>
#A better way is to 

<%= options_for_select([['Lisbon', 1],[],..])%>

#combining <select_tag> and <options_for_select>

<%= select_tag(:city_id, options_for_select([[],[],[],..],2))%> #2 says pre-select 2nd option

#when _tag is dropped it is used to update model directly
<%= select(:person, :city_id, [[Lisbon,1],[]])%> #here :person is the model
#using on a form buider
<%= f.select(:city_id, ..)%>

#for users to choose a timezone 
<%= time_zone_select(:person, :time_zone)%>


<% form_tag ({:action => "get"}, :multipart => true) do%>
	<%= file_field_tag 'picture'%>
	#params[:picture]
<% end %>

<% form_for @person, :html => {:multipart => true} do |f|%>
	<%= f.file_field :picture %> #params[:person][:picture]
<% end %>

#An instance of subclass of IO get uploaded
#it has original_filename and content_type attributes

def upload
  uploaded_io = params[:person][:picture]
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
    file.write(uploaded_io.read)
  end
end

#Customizing form builders

<% form_for @person, :builder => LabellingFormBuilder do |f| %>
	<%= f.text_field :first_name %>
<% end %>

#then define the class LabellingFormBuilder

class LabellingFormBuilder < ActionView::Helpers::FormBuilder
	def text_field
	end
end
