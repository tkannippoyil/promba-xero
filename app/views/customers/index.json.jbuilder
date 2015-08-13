json.array!(@customers) do |customer|
  json.extract! customer, :id, :first_name, :last_name, :date_of_birth, :home_address, :email, :mobile_number, :employment_basis, :classification, :gender, :pay_adjustment, :xeroemployeeid, :preferred_name, :is_supervisor
  json.url customer_url(customer, format: :json)
end
