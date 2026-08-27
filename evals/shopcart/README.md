# shopcart

Pricing helpers for the shop backend.

## Pricing rules

- All money is integer cents.
- Shipping estimate: days in transit between the order date and the delivery date. Ordered March 1, delivered March 4 = 3 days in transit.
- Rentals bill inclusively: every calendar day of the rental is a billable day, including both the start and the end date. A rental from March 10 to March 12 is 3 billable days. A same-day rental is 1 billable day.

## Tests

```
npm test
```
