class FlagsController < OpenReadController
  before_action :set_flag, only: [:show]

  # GET /flags
  # GET /flags.json
  def index
    @flags = Flag.all

    render json: @flags
  end

  # GET /flags/1
  # GET /flags/1.json
  def show
    render json: @flag
  end

  # POST /flags
  # POST /flags.json
  # def create
  #   @flag = Flag.new(flag_params)
  #
  #   if @flag.save
  #     render json: @flag, status: :created, location: @flag
  #   else
  #     render json: @flag.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /flags/1
  # PATCH/PUT /flags/1.json
  # def update
  #   @flag = Flag.find(params[:id])
  #
  #   if @flag.update(flag_params)
  #     render json: @flag, status: :created
  #   else
  #     render json: @flag.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /flags/1
  # DELETE /flags/1.json
  # def destroy
  #   @flag.destroy
  #
  #   head :no_content
  # end

  private

    def set_flag
      @flag = Flag.find(params[:id])
    end

    def flag_params
      params.require(:flag).permit(:location, :name, :level, :imgurl)
    end
end
