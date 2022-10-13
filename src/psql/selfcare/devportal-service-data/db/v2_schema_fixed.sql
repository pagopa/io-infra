ALTER TABLE "DeveloperPortalServiceData".services
     ADD COLUMN "requireSecureChannels" BOOLEAN DEFAULT FALSE; -- if true the message will be available only in the IOApp instead of both e-mail and IOApp
