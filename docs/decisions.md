# Decisions Record

This document contains three critical questions not answered by the initial description, the assumptions made to continue building the model, and how the model would change if the answer were different.

## 1. Payment Timing
* **Question:** Do customers pay upfront when they approve the estimate, or do they pay at the end when they pick up the bike?
* **Assumption made:** I assumed customers pay at the end upon pickup. Therefore, the state machine transitions from `Completed` to `Picked Up` and the repair is closed.
* **What would change:** If customers paid upfront, the `Repairs` table would need a `payment_status` boolean column, and the lifecycle would require an `Awaiting Payment` state before moving to `In Progress`.

## 2. Multiple Bikes per Ticket
* **Question:** Can a single repair ticket cover multiple bikes dropped off by the same family at the same time?
* **Assumption made:** I assumed one repair ticket corresponds to exactly one bike. 
* **What would change:** If a ticket could hold multiple bikes, the relationship would change. We would need a new `RepairTickets` table for the customer interaction, and the `Repairs` table would become a child table holding the individual bikes for that ticket.

## 3. Mechanic Assignment
* **Question:** Is a repair strictly assigned to a single mechanic for the entire process, or do all mechanics share a pool of work and step in whenever needed?
* **Assumption made:** I assumed the workshop operates as a shared pool. Whoever is available picks up the phone or the bike. 
* **What would change:** If repairs were strictly assigned to individuals, we would need to add a `Mechanics` (or `Users`) table, and add a `mechanic_id` foreign key to the `Repairs` table to track who is responsible for it.