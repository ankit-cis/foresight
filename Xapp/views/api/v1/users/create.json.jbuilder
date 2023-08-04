json.id @user.id
json.email @user.email
json.access_token @user.access_token
json.forename @user.forename
json.surname @user.surname
json.address @user.address
json.insurer @user.insurer
json.telephone_number @user.telephone_number
json.vehicle_registration @user.vehicle_registration
json.license @user.has_license?
json.current_user_device_id @current_user_device.id if @current_user_device
json.terms_accepted @user.terms_accepted