class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :not_valid

    def index
        campers = Camper.all 
        render json: campers, only: [:id, :name, :age], status: :ok
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, include: :activities, status: :ok
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def not_valid
        render json: { error: "Not Valid"}, status: :unprocessable_entity
    end

    def not_found
        render json: { error: "Camper not found" }, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end

end
