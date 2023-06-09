superme = User.find_by(username: 'zeekerpro@gmail.com');
superme = User.create(
  username: 'zeeker',
  email: 'zeekerpro@gmail.com',
  phone: '18088412517',
  password: '123456',
  password_confirmation: '123456'
) if superme.blank?

