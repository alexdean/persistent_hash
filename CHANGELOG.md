## 1.0.0 : June 8, 2026

  - **Breaking:** drop support for end-of-life Ruby and Rails versions.
  - Supported Ruby versions are now 3.3, 3.4 and 4.0 (Ruby 4.0 requires Rails 8.0+).
  - Supported Rails versions are now 7.2, 8.0 and 8.1 (`rails >= 7.2`).
  - Fix compatibility with Rails 7.1+ by removing the `legacy_connection_handling`
    setting from the dummy app (the option was removed from Rails).
  - Refresh the CI matrix and bump GitHub Actions, MySQL and PostgreSQL service versions.

## 0.7.0 : July 25, 2019

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
