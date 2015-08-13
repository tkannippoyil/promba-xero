class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :get_xero_client, only: [:index, :create]

  def index
    @customers = Customer.all
    @contacts = @client.Contact.all(:order => 'Name')
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        new_contact = @client.Contact.build(:name => @customer.first_name)
        new_contact.save
        format.html { redirect_to @customer, notice:
                      'Customer was successfully created.' }
        format.json { render :show, status: :created,
                      location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :date_of_birth, :home_address, :email, :mobile_number, :employment_basis, :classification, :gender, :pay_adjustment, :xeroemployeeid, :preferred_name, :is_supervisor)
  end

  def get_xero_client
    @client = Xeroizer::PublicApplication.new(
      XERO_CONFIG['consumer_key'],
      XERO_CONFIG['consumer_secret']
    )
    logger.info(session[:xero_auth]['access_token'] )
    logger.info(session[:xero_auth]['access_key'] )

    @client.authorize_from_access(
      session[:xero_auth]['access_token'],
      session[:xero_auth]['access_key']
    )

  end

end
