ALTER TABLE "SelfcareIOSubscriptionMigrations".migrations
    ADD COLUMN "isVisibile" TYPE boolean NOT NULL default false,
    ADD COLUMN "hasBeenVisibleOnce" TYPE boolean NOT NULL default false;
