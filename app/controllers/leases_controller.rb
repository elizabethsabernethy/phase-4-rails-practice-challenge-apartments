class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end


    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def render_not_found
        render json: {error:"Lease not found"}, status: :not_found
    end

    def render_invalid(invalid)
        render json: {errors:invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end

end
