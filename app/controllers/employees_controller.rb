class EmployeesController < ApplicationController
  before_action :admin_user, only: %i[index show]
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find_by_id(params[:id])
  end

  private

  def admin_user
    redirect_to(root_url) unless current_employee.present? && current_employee.admin?
  end

end
