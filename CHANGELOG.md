## 0.7.0 : July 16, 2019

  - do "select then insert/update/delete" instead of "always delete then always insert"
    to consume fewer autoinc values and hopefully prevent some deadlocks. [#6](https://github.com/alexdean/persistent_hash/pull/6)

## 0.0.6 : February 2, 2017

  - ensure that keys are updated within a transaction, so another thread cannot
    see a NULL value if it SELECTs while another thread is doing a
    DELETE and then INSERT.

## 0.0.5 : January 19, 2017

  - value column is now a TEXT rather than a VARCHAR. allow larger values.

## 0.0.4 : July 25, 2016

  - rails 5 support.
