class CohortsController < ApplicationController
  before_action :confirm_logged_in
  before_action :set_student
  before_action :set_cohort, only: [:show, :edit, :update, :destroy]
  layout "admin"
  # GET /cohorts
  # GET /cohorts.json
  def index
    # @cohorts = Cohort.all
    if params[:student_id] == nil
      @cohorts = Cohort.all
    else
      @enrollment = Enrollment.where(:student_id => params[:student_id])
      @cohorts = []
      @enrollment.each do |e|
        @cohorts << e.cohort
      end
    end
  end

  # GET /cohorts/1
  # GET /cohorts/1.json
  def show
    @cohort = Cohort.find(params[:id])
    @students = Student.all
  end

  def associate_cohort_to_student
    Enrollment.create(
      student_id: params[:student_id],
      cohort_id: params[:cohort_id],
    )

    redirect_to cohorts_path
  end

  # GET /cohorts/new
  def new
    @cohort = Cohort.new
  end

  # GET /cohorts/1/edit
  def edit
  end

  # POST /cohorts
  # POST /cohorts.json
  def create
    @cohort = Cohort.new(cohort_params)

    respond_to do |format|
      if @cohort.save
        format.html { redirect_to @cohort, notice: "Cohort was successfully created." }
        format.json { render :show, status: :created, location: @cohort }
      else
        format.html { render :new }
        format.json { render json: @cohort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cohorts/1
  # PATCH/PUT /cohorts/1.json
  def update
    respond_to do |format|
      if @cohort.update(cohort_params)
        format.html { redirect_to @cohort, notice: "Cohort was successfully updated." }
        format.json { render :show, status: :ok, location: @cohort }
      else
        format.html { render :edit }
        format.json { render json: @cohort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cohorts/1
  # DELETE /cohorts/1.json
  def destroy
    @cohort.destroy
    respond_to do |format|
      format.html { redirect_to cohorts_url, notice: "Cohort was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cohort
    @cohort = Cohort.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cohort_params
    params.require(:cohort).permit(:name, :begin_date, :end_date, :is_active, :comments)
  end

  def set_student
    begin
      @student = Student.find(params[:student_id])
    rescue
      @students = Student.all
    end
  end
end
