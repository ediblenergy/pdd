-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/6/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/7/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "account_soundcloud" (
  "service_credential_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "access_token" text NOT NULL,
  "refresh_token" text NOT NULL,
  "expires_at" integer NOT NULL,
  "souncloud_user_id" integer NOT NULL,
  "meta" text DEFAULT '{}' NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  "update_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("service_credential_id")
);
CREATE INDEX "account_soundcloud_idx_user_id" on "account_soundcloud" ("user_id");

;
ALTER TABLE "account_soundcloud" ADD CONSTRAINT "account_soundcloud_fk_service_credential_id_user_id" FOREIGN KEY ("service_credential_id", "user_id")
  REFERENCES "service_credential" ("service_credential_id", "user_id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE "account_soundcloud" ADD CONSTRAINT "account_soundcloud_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE service_credential_fetch DROP CONSTRAINT service_credential_fetch_fk_service_credential_id;

;
ALTER TABLE service_credential_fetch ADD CONSTRAINT service_credential_fetch_fk_service_credential_id FOREIGN KEY (service_credential_id)
  REFERENCES service_credential (service_credential_id) DEFERRABLE;

;

COMMIT;

