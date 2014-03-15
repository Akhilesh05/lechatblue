class PizzasController < ApplicationController
	before_action :set_pizza, only: [:show, :edit, :update, :destroy]

	# GET /pizzas
	# GET /pizzas.json
	def index
		@layout_details = {
				controller: params[:controller],
				action: params[:action],
				styles: [],
				other_styles: ["scaffolds"],
				scripts: [],
				other_scripts: ["scaffolds"]
		}
		@pizzas = Pizza.all
	end

	# GET /pizzas/1
	# GET /pizzas/1.json
	def show
    @layout_details = {
        controller: params[:controller],
        action: params[:action],
        styles: [],
        other_styles: ["scaffolds"],
        scripts: [],
        other_scripts: ["scaffolds"]
    }
	end

	# GET /pizzas/new
	def new
    @layout_details = {
        controller: params[:controller],
        action: params[:action],
        styles: [],
        other_styles: ["scaffolds"],
        scripts: [],
        other_scripts: ["scaffolds"]
    }
		@pizza = Pizza.new
	end

	# GET /pizzas/1/edit
	def edit
    @layout_details = {
        controller: params[:controller],
        action: params[:action],
        styles: [],
        other_styles: ["scaffolds"],
        scripts: [],
        other_scripts: ["scaffolds"]
    }
	end

	# POST /pizzas
	# POST /pizzas.json
	def create
    @layout_details = {
        controller: params[:controller],
        action: params[:action],
        styles: [],
        other_styles: ["scaffolds"],
        scripts: [],
        other_scripts: ["scaffolds"]
    }
		@pizza = Pizza.new(pizza_params)

		respond_to do |format|
			if @pizza.save
				format.html { redirect_to @pizza, notice: 'Pizza was successfully created.' }
				format.json { render action: 'show', status: :created, location: @pizza }
			else
				format.html { render action: 'new' }
				format.json { render json: @pizza.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /pizzas/1
	# PATCH/PUT /pizzas/1.json
	def update
    @layout_details = {
        controller: params[:controller],
        action: params[:action],
        styles: [],
        other_styles: ["scaffolds"],
        scripts: [],
        other_scripts: ["scaffolds"]
    }
		respond_to do |format|
			if @pizza.update(pizza_params)
				format.html { redirect_to @pizza, notice: 'Pizza was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @pizza.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /pizzas/1
	# DELETE /pizzas/1.json
	def destroy
    @layout_details = {
        controller: params[:controller],
        action: params[:action],
        styles: [],
        other_styles: ["scaffolds"],
        scripts: [],
        other_scripts: ["scaffolds"]
    }
		@pizza.destroy
		respond_to do |format|
			format.html { redirect_to pizzas_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_pizza
		@pizza = Pizza.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def pizza_params
		params.require(:pizza).permit(:name, :ingredients, :description, :price, :available, :veg, :image)
	end
end
