-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/2/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/3/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE account_google_federated_login ADD COLUMN meta text DEFAULT '{}' NOT NULL;

;

COMMIT;

