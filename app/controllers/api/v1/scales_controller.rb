module Api
	module V1
		class ScalesController < ApplicationController
		  def index
		    image_dimension = params['image_dimensions'].gsub(/"|\[|\]/, '').split(",")
		    bounding_box = params['bounding_box'].gsub(/"|\[|\]/, '').split(",")
		    bound_w = bounding_box[0].to_i
		    bound_h = bounding_box[1].to_i
		    new_image_dimension = []

		    if image_dimension.count%2 == 0 || bounding_box.length == 2
		      image_dimension = image_dimension.each_slice(2).to_a
		      image_dimension.each do |pair|
		        w = pair[0].to_f
		        h = pair[1].to_f
		        new_w = w/bound_w
		        new_h = h/bound_h

		        if new_w < new_h
		          new_w = (w/new_h).to_i
		          new_h = (h/new_h).to_i
		        else
		          new_h = (h/new_w).to_i
		          new_w = (w/new_w).to_i
		        end
		        new_image_dimension << [new_w, new_h]
		      end
		      new_image_dimension.flatten!
		      render json: {image_dimension: new_image_dimension, bounding_box: [bound_w,bound_h]}
		    else
		    	error = "Your Input was not correct. Please check and retry."
		    	render json: error, status: 400
		    end
		  end
		end
	end
end