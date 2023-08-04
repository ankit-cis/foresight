puts "Seeding Statuses"
Status.create([
  { name: 'Not Actioned', description: 'Not Actioned', status_constant: 'REPORTED', sort_order: 1 },
  { name: 'In Progress', description: 'In Progress', status_constant: 'IN_PROGRESS', sort_order: 2 },
  { name: 'Actioned', description: 'Actioned', status_constant: 'ACTIONED', sort_order: 3 },
  { name: 'Actioned - False Alarm', description: 'Actioned - False Alarm', status_constant: 'ACTIONED_FALSE_ALARM', sort_order: 4 },
  { name: 'Actioned - Fault', description: 'Actioned - Fault', status_constant: 'ACTIONED_FAULT', sort_order: 5 },
  { name: 'Actioned - Non Fault', description: 'Actioned - Non Fault', status_constant: 'ACTIONED_NON_FAULT', sort_order: 6 }
])
