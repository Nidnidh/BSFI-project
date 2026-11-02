# Power BI build guide — Credit Risk

## Import
Import the three CSV files from `data/`. Rename tables exactly `borrowers`, `loans`, `repayments`.

## Model relationships
- `borrowers[borrower_id]` 1 → many `loans[borrower_id]`
- `loans[loan_id]` 1 → many `repayments[loan_id]`
Use single-direction filtering from dimensions to facts.

## Suggested DAX measures
```DAX
Total Loans = DISTINCTCOUNT(loans[loan_id])
Total Loan Value = SUM(loans[loan_amount])
Average Loan Amount = AVERAGE(loans[loan_amount])
Defaulted Loans = CALCULATE(DISTINCTCOUNT(loans[loan_id]), loans[default_flag] = 1)
Default Rate % = DIVIDE([Defaulted Loans], [Total Loans], 0)
Approved Loans = CALCULATE([Total Loans], loans[loan_status] = "Approved")
Approval Rate % = DIVIDE([Approved Loans], [Total Loans], 0)
Repayment Gap = SUMX(repayments, repayments[amount_due] - repayments[amount_paid])
Late Repayments = CALCULATE(COUNTROWS(repayments), repayments[payment_status] = "Late")
Average DPD = AVERAGE(repayments[days_past_due])
```

## Page 1 — Executive overview
KPI cards: Total Loans, Total Loan Value, Default Rate %, Approval Rate %.
Visuals: monthly applications line chart; loan type by total loan value; default rate by loan type; slicers for application date, loan type, loan status.

## Page 2 — Credit risk
Visuals: default rate by credit-score band, employment type and city tier; scatter plot income vs loan amount with default flag legend; risk review table.

## Page 3 — Repayment operations
Visuals: late/partial/on-time repayment distribution; average days past due by loan type; repayment gap by month; table of top repayment gaps.

## Validation
Compare card values with SQL outputs. Explain that the data is synthetic and risk bands are analytical indicators, not a substitute for fair-lending review or regulated underwriting.
