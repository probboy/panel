class StudentsController < ApplicationController
  before_action :confirm_logged_in

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  layout "admin"
  # GET /students
  # GET /students.json
  def index
    #@students = Student.all
    # @cohorts = Cohort.all
    if params[:cohort_id] == nil
      @students = Student.all
    else
      @enrollment = Enrollment.where(:cohort_id => params[:cohort_id])
      @students = []
      @enrollment.each do |e|
        @students << e.student
      end
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show
    @student = Student.find(params[:id])
    @cohorts = Cohort.all
  end

  def associate_student_to_cohort
    Enrollment.create(
      student_id: params[:student_id],
      cohort_id: params[:cohort_id],
    )

    redirect_to cohorts_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :is_enrolled, :comments)
  end
end
