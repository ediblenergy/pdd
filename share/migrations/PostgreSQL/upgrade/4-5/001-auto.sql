-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/4/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/5/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE account_google_reader DROP CONSTRAINT account_google_reader_fk_email;

;
ALTER TABLE account_google_reader ADD COLUMN update_date timestamp with time zone;
ALTER TABLE account_google_reader ADD COLUMN last_fetch timestamp with time zone;

update account_google_reader set update_date='epoch'::timestamptz, last_fetch='epoch'::timestamptz;

ALTER TABLE account_google_reader ALTER COLUMN update_date SET NOT NULL;
ALTER TABLE account_google_reader ALTER COLUMN last_fetch SET NOT NULL;

;
ALTER TABLE account_google_reader ADD CONSTRAINT account_google_reader_fk_email FOREIGN KEY (email)
  REFERENCES account_google_federated_login (email) ON DELETE CASCADE DEFERRABLE;

;

COMMIT;

