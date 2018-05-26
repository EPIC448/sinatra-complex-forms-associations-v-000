class OwnersController < ApplicationController
 # All the owner and pets are loaded automaticly from our data base.
 # you dont have to use a patch request

  get '/owners' do   #load up all the pets
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    # create a new owner
    @owner = Owner.create(params[:owner])

    # control for creating a new pet (if pet and name is empty)
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect to "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

# this is updating /// This method is just an update not create anything new.(patch)

  post '/owners/:id' do
    @owner = Owner.find(params[:id])
    # update effect
    @owner.update(params["owner"])   #.update is a activerecord method

    if !params["pet"]["name"].empty?
      #this is what is tracking the changes.... When it updated in the edit file
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}"
  end
end
