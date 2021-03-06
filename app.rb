require("bundler/setup")
Bundler.require(:default)
require('pry')
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

#Route to the index
get("/") do
  erb(:index)
end

#routed all stores pages for the brands
get('/stores') do
  @all_stores = Store.all()
  erb(:stores)
end
#posting anew store to database
post('/stores/create_new_store') do
  name_input = params[:name_input]
  @new_store = Store.create({:name => name_input})
  if @new_store.save
    redirect('/stores')
  else
    erb(:error)
  end
end

# returns the current store in the database
get('/stores/store/:id') do
  @current_store = Store.find(params[:id])
  @current_store_brands = @current_store.brands
  @all_brands = Brand.all
  erb(:store)
end

#patching and add brand
patch('/store/:id/add_brand') do
  @current_store = Store.find(params[:id])
  @added_brand = Brand.find(params[:added_brand])
  if @current_store.brand_unique_per_store(@added_brand)
    @current_store.brands.push(@added_brand)
    redirect("/stores/store/#{@current_store.id}")
  else
    erb(:error)
  end
end

#patching and updating anew store
patch('/store/:id/update_name') do
  @current_store = Store.find(params[:id])
  new_name = params[:new_name]
  if @current_store.update({:name => new_name})
    redirect("/stores/store/#{@current_store.id}")
  else
    erb(:error)
  end
end

#returns  all brands in DB
get('/brands') do
  @all_brands = Brand.all()
  erb(:brands)
end
# Posting anew brand to the DB and return error
post('/brands/create_new_brand') do
  name_input = params[:name_input]
  @new_brand = Brand.create({:name => name_input})
  if @new_brand.save
    redirect('/brands')
  else
    erb(:error)
  end
end

get('/brands/brand/:id') do
  @current_brand = Brand.find(params[:id])
  erb(:brand)
end
# update an  existing brand
patch('/brand/:id/update_name') do
  @current_brand = Brand.find(params[:id])
  new_name = params[:new_name]
  if @current_brand.update({:name => new_name})
    redirect("/brands/brand/#{@current_brand.id}")
  else
    erb(:error)
  end
end

#Deleting a store and redirecting bacck to stores
delete('/store/:id/delete') do
  @current_store = Store.find(params[:id])
  @current_store.destroy
  redirect('/stores')
end
