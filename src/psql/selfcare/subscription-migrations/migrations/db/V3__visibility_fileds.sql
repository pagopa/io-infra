ALTER TABLE "SelfcareIOSubscriptionMigrations".migrations
    -- In order to avoid null fileds, we set FALSE as default
    -- This is harmless as
    --  * we will ensure this field to be set at insert time
    --  * the field is not considered yet by the application (at the time of writing)
    ADD COLUMN "isVisibile" boolean NOT NULL default false,
    ADD COLUMN "hasBeenVisibleOnce"  boolean NOT NULL default false;
