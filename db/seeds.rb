RepairService.destroy_all
Repair.destroy_all
Bike.destroy_all
Customer.destroy_all
Service.destroy_all
Employee.destroy_all

s1  = Service.create!(name: "Basic Tune-Up", price: 75.00)
s2  = Service.create!(name: "Comprehensive Tune-Up", price: 120.00)
s3  = Service.create!(name: "Flat Tire Fix", price: 15.00)
s4  = Service.create!(name: "Brake Bleed", price: 35.00)
s5  = Service.create!(name: "Chain Replacement", price: 25.00)
s6  = Service.create!(name: "Wheel Truing", price: 30.00)
s7  = Service.create!(name: "Gear Adjustment", price: 20.00)
s8  = Service.create!(name: "Brake Pad Replacement", price: 20.00)
s9  = Service.create!(name: "Fork Overhaul", price: 90.00)
s10 = Service.create!(name: "Shock Overhaul", price: 85.00)
s11 = Service.create!(name: "Bottom Bracket Overhaul", price: 40.00)
s12 = Service.create!(name: "Headset Overhaul", price: 35.00)
s13 = Service.create!(name: "Custom Bike Build", price: 250.00)
s14 = Service.create!(name: "Box Bike for Shipping", price: 60.00)
s15 = Service.create!(name: "Install Bar Tape", price: 15.00)
s16 = Service.create!(name: "Spoke Replacement", price: 25.00)
s17 = Service.create!(name: "Hub Overhaul", price: 45.00)
s18 = Service.create!(name: "Derailleur Hanger Alignment", price: 20.00)
s19 = Service.create!(name: "Frame Alignment", price: 70.00)
s20 = Service.create!(name: "Bike Wash and Degrease", price: 40.00)

m1 = Employee.create!(name: "Alex Rivera", role: "Mechanic")
m2 = Employee.create!(name: "Jordan Lee", role: "Mechanic")
m3 = Employee.create!(name: "Sam Taylor", role: "Mechanic")
c1 = Employee.create!(name: "Casey Smith", role: "Counter")

customers = [
  "Maria Garcia", "David Chen", "Sarah Johnson", "Michael Brown", "Emily Davis",
  "James Wilson", "Linda Martinez", "Robert Anderson", "William Thomas", "Elizabeth Jackson"
].map { |name| Customer.create!(name: name, phone: "555-#{rand(1000..9999)}") }

customer_no_repairs = customers.last # Elizabeth Jackson no tendrá reparaciones

b1  = Bike.create!(customer_id: customers[0].id, make: "Trek", model: "Marlin", color: "Blue", serial_number: "TK123456")
b2  = Bike.create!(customer_id: customers[0].id, make: "Specialized", model: "Sirrus", color: "Black", serial_number: "SP987654")
b3  = Bike.create!(customer_id: customers[1].id, make: "Trek", model: "Marlin", color: "Blue", serial_number: "TK123457") # Gemela de b1
b4  = Bike.create!(customer_id: customers[2].id, make: "Giant", model: "Escape", color: "Red", serial_number: "GT111222")
b5  = Bike.create!(customer_id: customers[3].id, make: "Cannondale", model: "Quick", color: "Silver", serial_number: "CN333444")
b6  = Bike.create!(customer_id: customers[4].id, make: "Santa Cruz", model: "Chameleon", color: "Green", serial_number: "SC555666")
b7  = Bike.create!(customer_id: customers[5].id, make: "Brompton", model: "C Line", color: "Orange", serial_number: "BR777888")
b8  = Bike.create!(customer_id: customers[6].id, make: "Cervelo", model: "Roubaix", color: "Yellow", serial_number: "CV999000")
b9  = Bike.create!(customer_id: customers[7].id, make: "Bianchi", model: "Oltre", color: "Celeste", serial_number: "BI222333")
b10 = Bike.create!(customer_id: customers[8].id, make: "Scott", model: "Spark", color: "Black", serial_number: "ST444555")
b11 = Bike.create!(customer_id: customers[1].id, make: "Yeti", model: "SB130", color: "Turquoise", serial_number: "YT666777")
b12 = Bike.create!(customer_id: customers[2].id, make: "Pinarello", model: "Dogma", color: "Red", serial_number: "PN888999")

r1 = Repair.create!(bike_id: b1.id, employee_id: m1.id, state: "In Progress", promised_on: 2.days.ago.to_date)
RepairService.create!(repair_id: r1.id, service_id: s1.id, charged_price: s1.price - 10.0) # Descuento exigido!

r2 = Repair.create!(bike_id: b2.id, employee_id: m2.id, state: "Picked Up", promised_on: 1.day.ago.to_date, handed_back_at: 1.day.ago, customer_answer: "Approved", created_at: 1.day.ago.beginning_of_day + 10.hours)
RepairService.create!(repair_id: r2.id, service_id: s3.id, charged_price: s3.price)

r3 = Repair.create!(bike_id: b3.id, employee_id: m3.id, state: "Declined", promised_on: 1.day.from_now.to_date, customer_answer: "Too expensive right now")
RepairService.create!(repair_id: r3.id, service_id: s2.id, charged_price: s2.price)

r4 = Repair.create!(bike_id: b4.id, employee_id: m1.id, state: "Picked Up", promised_on: 1.month.ago.to_date, handed_back_at: 1.month.ago, customer_answer: "Approved", created_at: 1.month.ago - 2.days)
RepairService.create!(repair_id: r4.id, service_id: s1.id, charged_price: s1.price)

r5 = Repair.create!(bike_id: b4.id, employee_id: m2.id, state: "Received", promised_on: 2.days.from_now.to_date)
RepairService.create!(repair_id: r5.id, service_id: s4.id, charged_price: s4.price)

r6 = Repair.create!(bike_id: b5.id, employee_id: m3.id, state: "Picked Up", promised_on: 2.years.ago.to_date, handed_back_at: 2.years.ago + 1.day, customer_answer: "Approved", created_at: 2.years.ago)
RepairService.create!(repair_id: r6.id, service_id: s1.id, charged_price: 45.00) 

r7 = Repair.create!(bike_id: b6.id, employee_id: nil, state: "Received", promised_on: 3.days.from_now.to_date)
RepairService.create!(repair_id: r7.id, service_id: s5.id, charged_price: s5.price)

r8 = Repair.create!(bike_id: b7.id, employee_id: m1.id, state: "Estimating", promised_on: 4.days.from_now.to_date)
RepairService.create!(repair_id: r8.id, service_id: s6.id, charged_price: s6.price)

r9 = Repair.create!(bike_id: b8.id, employee_id: m2.id, state: "Waiting for Approval", promised_on: 3.days.from_now.to_date)
RepairService.create!(repair_id: r9.id, service_id: s16.id, charged_price: s16.price)

r10 = Repair.create!(bike_id: b9.id, employee_id: m3.id, state: "Approved", promised_on: 2.days.from_now.to_date, customer_answer: "Yes, go ahead")
RepairService.create!(repair_id: r10.id, service_id: s8.id, charged_price: s8.price)

r11 = Repair.create!(bike_id: b10.id, employee_id: m1.id, state: "Completed", promised_on: Date.current, customer_answer: "Approved")
RepairService.create!(repair_id: r11.id, service_id: s10.id, charged_price: s10.price)

r12 = Repair.create!(bike_id: b11.id, employee_id: m2.id, state: "In Progress", promised_on: 1.day.from_now.to_date, customer_answer: "Approved")
RepairService.create!(repair_id: r12.id, service_id: s11.id, charged_price: s11.price)

r13 = Repair.create!(bike_id: b12.id, employee_id: m3.id, state: "Picked Up", promised_on: 1.week.ago.to_date, handed_back_at: 1.week.ago, customer_answer: "Approved", created_at: 1.week.ago - 3.days)
RepairService.create!(repair_id: r13.id, service_id: s13.id, charged_price: s13.price)
RepairService.create!(repair_id: r13.id, service_id: s14.id, charged_price: s14.price)

r14 = Repair.create!(bike_id: b1.id, employee_id: nil, state: "Received", promised_on: Date.current + 5.days)
RepairService.create!(repair_id: r14.id, service_id: s15.id, charged_price: s15.price)

r15 = Repair.create!(bike_id: b2.id, employee_id: m1.id, state: "Estimating", promised_on: Date.current + 6.days)
RepairService.create!(repair_id: r15.id, service_id: s17.id, charged_price: s17.price)
