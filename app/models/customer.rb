class Customer < ActiveRecord::Base
  # validates_uniqueness_of :first_name

  def sync_with_xero(xero_client)
    xero_new_contact = xero_client.Contact.build(
        first_name: first_name,
        last_name: last_name,
        name: first_name + ' ' + last_name,
        is_customer: true,
        email_address: email,
    )
    xero_new_contact.save
    self.xero_id = xero_new_contact.id
    self.save()
  end
end
