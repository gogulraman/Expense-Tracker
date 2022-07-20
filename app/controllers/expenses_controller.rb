require 'net/http'
require 'uri'
require 'json'

class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :authenticate_employee!, only: %i[ show edit update destroy ]
  before_action :admin_user, only: %i[edit upate]
  #before_action :correct_user , only: [:edit, :update, :destroy]
  
  # GET /expenses or /expenses.json
  def index
    @expenses = Expense.all
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    @expense = current_employee.expenses.build
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(expense_params)
    @expense = current_employee.expenses.build(expense_params)
    @expense.statusEmp = "Waiting"
    if @expense.invoice_number % 2 == 1
      @expense.statusEmp = "Rejected"
    end
    if @current_employee.status == true
      respond_to do |format|

        if @expense.save
          format.html { redirect_to expense_url(@expense), notice: "Expense was successfully created." }
          format.json { render :show, status: :created, location: @expense }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @expense.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: "You are not a part of this organization"
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def invoc_check(expense)
  #   invoc = @expense.invoice_number
  #   if invoc % 2 == 0
  #       expense.update(accept: true)
  #   elsif invoice % 2 != 0
  #       expense.update(statusEmp: “Rejected”)
  #   end
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:invoice_number, :category, :description, :amount, :statusEmp, :employee_id, :date)
    end

    def admin_user
      redirect_to(root_url) unless current_employee.present? && current_employee.admin?
    end
    

end
