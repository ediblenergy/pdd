-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/5/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/6/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "service_credential_fetch" (
  "service_credential_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "num_fetched" integer DEFAULT 0 NOT NULL,
  "last_fetch" timestamp with time zone NOT NULL,
  PRIMARY KEY ("service_credential_id", "last_fetch")
);
CREATE INDEX "service_credential_fetch_idx_service_credential_id" on "service_credential_fetch" ("service_credential_id");
CREATE INDEX "service_credential_fetch_idx_user_id" on "service_credential_fetch" ("user_id");

;
ALTER TABLE "service_credential_fetch" ADD CONSTRAINT "service_credential_fetch_fk_service_credential_id" FOREIGN KEY ("service_credential_id")
  REFERENCES "service_credential" ("service_credential_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "service_credential_fetch" ADD CONSTRAINT "service_credential_fetch_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE user_link DROP CONSTRAINT user_link_fk_user_id;

;
ALTER TABLE account_google_reader DROP COLUMN last_fetch;

;
ALTER TABLE user_link ADD CONSTRAINT user_link_fk_user_id FOREIGN KEY (user_id)
  REFERENCES "user" (user_id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

