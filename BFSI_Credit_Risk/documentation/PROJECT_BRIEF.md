# Project 1: Loan Default & Credit Risk Analytics

## Company background
A fictional retail lender offers personal, home, vehicle, education and business loans. The lender wants a consistent view of portfolio risk and repayment operations.

## Business problem
Credit and operations teams cannot quickly identify which loan products and borrower profiles are associated with elevated default and delinquency patterns.

## Objectives
1. Establish portfolio-level loan and default KPIs.
2. Compare default rates by loan type and borrower segment.
3. Monitor payment delays and repayment gaps.
4. Create a review queue for further investigation without automatically rejecting applicants.

## Stakeholders
Chief Risk Officer, Credit Manager, Collections Lead, Branch Operations, Finance, Compliance and BI Analyst.

## KPIs
Total loans; total loan value; default rate; approval rate; average loan amount; late repayment share; average days past due; repayment gap.

## Dataset
Synthetic teaching dataset generated for this portfolio: borrowers, loans and repayments CSVs. Inspect row counts and data types after import. Keys: borrower_id and loan_id.

## Key business questions
- Which loan types have the highest observed default rate?
- Does default rate vary by credit-score band or employment type?
- Which months show changes in application volume?
- Where are late repayments and repayment gaps concentrated?
- What cases should be queued for manual review?

## As-is / To-be
As-is: separate spreadsheets and manual summaries.
To-be: relational SQL model, repeatable risk queries and a three-page Power BI report.

## Risks and assumptions
All data is synthetic, not real borrower information. The dataset is for analytics practice only. Correlation is not causation; do not use the illustrative rules for real credit decisions.

## Acceptance criteria
- All CSVs import with correct keys and types.
- SQL counts reconcile with imported row counts.
- Power BI relationships work without ambiguous paths.
- Every KPI has a clear definition.
- Report filters work across relevant visuals.
- Recommendations cite observed evidence and a proposed owner/metric.
