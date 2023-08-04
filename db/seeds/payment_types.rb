puts "Seeding Payment Types"
PaymentType.create([
  { name: 'Credit Card', description: 'Credit Card payment', payment_type_const: 'CREDIT_CARD' },
  { name: 'Direct Debit', description: 'Direct debit payment', payment_type_const: 'DIRECT_DEBIT' },
  { name: 'Free', description: 'No payment required', payment_type_const: 'FREE' }
])
