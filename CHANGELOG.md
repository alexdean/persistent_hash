## 0.0.6 : February 2, 2017

  - ensure that keys are updated within a transaction, so another thread cannot
    see a NULL value if it SELECTs while another thread is doing a
    DELETE and then INSERT.

## 0.0.5 : January 19, 2017

  - value column is now a TEXT rather than a VARCHAR. allow larger values.

## 0.0.4 : July 25, 2016

  - rails 5 support.