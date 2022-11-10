class MissionsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
    
    def create
        mission = Mission.create!(mission_params)
        render json: mission.planet, status: 201
    end

    private

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end

    def render_invalid(error)
        render json: {errors: error.record.errors.full_messages}, status: 422
    end

end
