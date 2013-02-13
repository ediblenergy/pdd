-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/7/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/8/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "oauth2_credential" (
  "access_token" integer NOT NULL,
  "refresh_token" text NOT NULL,
  "expires_at" integer,
  "scope" text NOT NULL,
  "token_type" text NOT NULL,
  "service_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  "update_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("access_token")
);
CREATE INDEX "oauth2_credential_idx_service_id" on "oauth2_credential" ("service_id");
CREATE INDEX "oauth2_credential_idx_user_id" on "oauth2_credential" ("user_id");
CREATE INDEX "oauth2_credential_create_date_idx" on "oauth2_credential" ("create_date");

;
ALTER TABLE "oauth2_credential" ADD CONSTRAINT "oauth2_credential_fk_service_id" FOREIGN KEY ("service_id")
  REFERENCES "service" ("service_id") DEFERRABLE;

;
ALTER TABLE "oauth2_credential" ADD CONSTRAINT "oauth2_credential_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") DEFERRABLE;

;

COMMIT;

