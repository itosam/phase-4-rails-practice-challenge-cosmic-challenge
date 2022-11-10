class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        render json: Scientist.all, status: :ok
    end

    def show
        scientist = Scientist.find(params[:id])
        render json: scientist, serializer: ScientistPlanetsSerializer, status: :ok
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: 201
    end

    def update
        scientist = Scientist.find(params[:id])
        scientist.update!(scientist_params)
        render json: scientist, status: 202
    end

    def destroy
        scientist = Scientist.find(params[:id])
        scientist.destroy
        head :no_content
    end

    private

    def scientist_params
        params.permit(:name, :field_of_study, :avatar )
    end

    def render_not_found
        render json: {error: "Scientist not found"}, status: :not_found
    end

    def render_invalid(error)
        render json: {errors: error.record.errors.full_messages}, status: 422
    end

end
