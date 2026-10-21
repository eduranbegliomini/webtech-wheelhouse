# Wheelhouse API Documentation

## Endpoints

| Verb  | Path | Needs Token? | Statuses |
|-------|------|--------------|----------|
| GET   | `/api/v1/services` | No | 200 |
| GET   | `/api/v1/services/:id` | No | 200, 404 |
| POST  | `/api/v1/services` | Yes | 201, 400, 401, 422 |
| GET   | `/api/v1/repairs` | Yes | 200, 400, 401 |
| GET   | `/api/v1/repairs/:id` | Yes | 200, 401, 404 |

## Decisions
- **Prices:** All prices are transmitted as `String` (e.g., `"15.50"`) to prevent floating-point precision loss in JSON parsers.
- **Repair Document Exclusions:** Foreign keys (`bike_id`, `employee_id`), internal timestamps (`updated_at`), and customer phone numbers are deliberately excluded from the Repair payload as the accounting software only needs financial and identification summaries, not privacy-sensitive or database-internal data.

## Shapes

**Service Shape:**
```json
{
  "id": 1,
  "name": "Basic Tune-Up",
  "price": "65.0",
  "charged_count": 12
}

**Repair Shape:**
```json
{
  "id": 4,
  "state": "completed",
  "arrived_on": "2026-10-15",
  "promised_on": "2026-10-18",
  "handed_back_at": null,
  "overdue": false,
  "customer_answer": "Approved all",
  "total": "80.0",
  "bike": { "brand": "Trek", "model": "Marlin", "serial_number": "TRK123" },
  "customer": { "name": "Elena" },
  "lines": [ { "service_name": "Flat Tire Fix", "charged_price": "15.0" } ]
}

**Error Shape:**
```json
{ "errors": ["Record not found"] }