ALTER TABLE "DeveloperPortalServiceData".services
     ADD COLUMN "requireSecureChannels" NOT NULL; -- if true the message will be available only in the IOApp instead of both e-mail and IOApp