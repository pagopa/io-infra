ALTER TABLE "SelfcareIOSubscriptionMigrations".migrations
    ALTER COLUMN "subscriptionId" TYPE character(50),
    ALTER COLUMN "sourceName" TYPE text,
    ALTER COLUMN "sourceSurname" TYPE text,
    ALTER COLUMN "sourceEmail" TYPE text,
    ALTER COLUMN "status" TYPE text,
    ALTER COLUMN "note" TYPE text,
    ALTER COLUMN "serviceName" TYPE text;
