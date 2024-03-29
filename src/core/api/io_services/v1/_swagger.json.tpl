{
  "swagger": "2.0",
  "info": {
    "version": "3.34.0",
    "title": "IO API for Public Administration Services",
    "contact": {
      "name": "PagoPA S.p.A.",
      "url": "https://docs.pagopa.it/io-guida-tecnica/"
    },
    "x-logo": {
      "url": "https://io.italia.it/assets/img/io-logo-blue.svg"
    },
    "description": "# Warning\n**This is an experimental API that is (most probably) going to change as we evolve the IO platform.**\n# Introduction\nThis is the documentation of the IO API for 3rd party services. This API enables Public Administration services to integrate with the IO platform. IO enables services to communicate with Italian citizens via the [IO app](https://io.italia.it/).\n# How to get an API key\nTo get access to this API, you'll need to register on the [IO Developer Portal](https://developer.io.italia.it/).\nAfter the registration step, you have to click on the button that says `subscribe to the digital citizenship api` to receive the API key that you will use to authenticate the API calls.\nYou will also receive an email with further instructions, including a fake Fiscal Code that you will be able to use to send test messages. Messages sent to the fake Fiscal Code will be notified to the email address used during the registration process on the developer portal.\n# Messages\n## What is a message\nMessages are the primary form of communication enabled by the IO APIs. Messages are **personal** communications directed to a **specific citizen**. You will not be able to use this API to broadcast a message to a group of citizens, you will have to create and send a specific, personalized message to each citizen you want to communicate to.\nThe recipient of the message (i.e. a citizen) is identified trough his [Fiscal Code](https://it.wikipedia.org/wiki/Codice_fiscale).\n## Message format\nA message is conceptually very similar to an email and, in its simplest form, is composed of the following attributes:\n\n  * A required `subject`: a short description of the topic.\n  * A required `markdown` body: a Markdown representation of the body (see\n    below on what Markdown tags are allowed).\n  * An optional `payment_data`: in case the message is a payment request,\n    the _payment data_ will enable the recipient to pay the requested amount\n    via [PagoPA](https://www.agid.gov.it/it/piattaforme/pagopa).\n  * An optional `due_date`: a _due date_ that let the recipient\n    add a reminder when receiving the message. The format for all\n    dates is [ISO8601](https://it.wikipedia.org/wiki/ISO_8601) with time\n    information and UTC timezone (ie. \"2018-10-13T00:00:00.000Z\").\n  * An optional `feature_level_type`: the kind of the submitted message.\n\n    It can be:\n    - `STANDARD` for normal messages;\n    - `ADVANCED` to enable premium features.\n\n    Default is `STANDARD`.\n\n## Allowed Markdown formatting\nNot all Markdown formatting is currently available. Currently you can use the following formatting:\n\n  * Headings\n  * Text stylings (bold, italic, etc...)\n  * Lists (bullet and numbered)\n\n## Sending a message to a citizen\nNot every citizen will be interested in what you have to say and not every citizen you want to communicate to will be registered on IO. For this reason, before sending a message you need to check whether the recipient is registered on the platform and that he has not yet opted out from receiving messages from you.\nThe process for sending a message is made of 3 steps:\n\n  1. Call [getProfile](#operation/getProfile): if the profile does not exist\n     (i.e. you get a 404 response) or if the recipient has opted-out from\n     your service (the response contains `sender_allowed: false`), you\n     cannot send the message and you must stop here.\n  1. Call [submitMessageforUser](#operation/submitMessageforUser) to submit\n     a new message.\n  1. (optional) Call [getMessage](#operation/getMessage) to check whether\n     the message has been notified to the recipient.\n"
  },
  "host": "api.io.pagopa.it",
  "basePath": "/api/v1",
  "schemes": [
    "https"
  ],
  "security": [
    {
      "SubscriptionKey": []
    }
  ],
  "paths": {
    "/messages": {
      "post": {
        "operationId": "submitMessageforUserWithFiscalCodeInBody",
        "summary": "Submit a Message passing the user fiscal_code in the request body",
        "description": "Submits a message to a user with STANDARD or ADVANCED features based on `feature_level_type` value.\nOn error, the reason is returned in the response payload.\nIn order to call `submitMessageforUser`, before sending any message,\nthe sender MUST call `getProfile` and check that the profile exists\n(for the specified fiscal code) and that the `sender_allowed` field\nof the user's profile it set to `true`.",
        "parameters": [
          {
            "name": "message",
            "in": "body",
            "schema": {
              "$ref": "#/definitions/NewMessage"
            },
            "x-examples": {
              "application/json": {
                "time_to_live": 3600,
                "content": {
                  "subject": "ipsum labore deserunt fugiat",
                  "markdown": "Nullam dapibus metus sed elementum efficitur. Curabitur facilisis sagittis risus nec sodales.\nVestibulum in eros sapien. Donec ac odio sit amet dui semper ornare eget nec odio. Pellentesque habitant\nmorbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent nibh ex, mattis sit amet\nfelis id, sodales euismod velit. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                }
              }
            }
          }
        ],
        "responses": {
          "201": {
            "description": "Message created.",
            "schema": {
              "$ref": "#/definitions/CreatedMessage"
            },
            "headers": {
              "Location": {
                "type": "string",
                "description": "Location (URL) of created message resource.\nA GET request to this URL returns the message status and details."
              }
            },
            "examples": {
              "application/json": {
                "id": "01BX9NSMKVXXS5PSP2FATZMYYY"
              }
            }
          },
          "400": {
            "description": "Invalid payload.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            },
            "examples": {}
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "The message cannot be delivered.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/messages/{fiscal_code}": {
      "post": {
        "operationId": "submitMessageforUser",
        "summary": "Submit a Message passing the user fiscal_code as path parameter",
        "description": "Submits a message to a user.\nOn error, the reason is returned in the response payload.\nIn order to call `submitMessageforUser`, before sending any message,\nthe sender MUST call `getProfile` and check that the profile exists\n(for the specified fiscal code) and that the `sender_allowed` field\nof the user's profile it set to `true`.",
        "parameters": [
          {
            "$ref": "#/parameters/FiscalCode"
          },
          {
            "name": "message",
            "in": "body",
            "schema": {
              "$ref": "#/definitions/NewMessage"
            },
            "x-examples": {
              "application/json": {
                "time_to_live": 3600,
                "content": {
                  "subject": "ipsum labore deserunt fugiat",
                  "markdown": "Nullam dapibus metus sed elementum efficitur. Curabitur facilisis sagittis risus nec sodales.\nVestibulum in eros sapien. Donec ac odio sit amet dui semper ornare eget nec odio. Pellentesque habitant\nmorbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent nibh ex, mattis sit amet\nfelis id, sodales euismod velit. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                }
              }
            }
          }
        ],
        "responses": {
          "201": {
            "description": "Message created.",
            "schema": {
              "type": "object",
              "properties": {
                "id": {
                  "type": "string",
                  "description": "The identifier of the created message."
                }
              }
            },
            "headers": {
              "Location": {
                "type": "string",
                "description": "Location (URL) of created message resource.\nA GET request to this URL returns the message status and details."
              }
            },
            "examples": {
              "application/json": {
                "id": "01BX9NSMKVXXS5PSP2FATZMYYY"
              }
            }
          },
          "400": {
            "description": "Invalid payload.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            },
            "examples": {}
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "The message cannot be delivered.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/messages/{fiscal_code}/{id}": {
      "get": {
        "operationId": "getMessage",
        "summary": "Get Message",
        "description": "The previously created message with the provided message ID is\nreturned. With right permission and `ADVANCED` feature level type\nrelated to the previously submitted message, also read and payment\nstatus infos (when applicable) are returned.",
        "parameters": [
          {
            "$ref": "#/parameters/FiscalCode"
          },
          {
            "name": "id",
            "in": "path",
            "type": "string",
            "required": true,
            "description": "The ID of the message."
          }
        ],
        "responses": {
          "200": {
            "description": "Message found.",
            "schema": {
              "$ref": "#/definitions/ExternalMessageResponseWithContent"
            },
            "examples": {
              "application/json": {
                "status": "PROCESSED",
                "message": {
                  "id": "01BX9NSMKAAAS5PSP2FATZM6BQ",
                  "fiscal_code": "QXJNTX9RCRVD6V4O",
                  "time_to_live": 3600,
                  "content": {
                    "subject": "message subject, aliquip sint nulla in estinut",
                    "markdown": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas et mollis felis.\nVivamus orci nisl, commodo ut sodales ut, eleifend a libero. Donec dapibus, turpis in mattis tempor,\nrisus nunc malesuada ex, non aliquet metus nunc a lacus. Aenean in arcu vitae nisl porta\nfermentum nec non nibh. Phasellus tortor tellus, semper in metus eget, eleifend\nlaoreet nibh. Aenean feugiat lectus ut nisl eleifend gravida."
                  },
                  "sender_service_id": "01BX9NSMKVXXS5PSP2FATZM6QX"
                },
                "notification": {
                  "email": "QUEUED"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "No message found for the provided ID.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          }
        }
      }
    },
    "/profiles": {
      "post": {
        "operationId": "getProfileByPOST",
        "summary": "Get a User Profile using POST",
        "description": "Returns the preferences for the user identified by the\nfiscal code provided in the request body. The field `sender_allowed` is set fo `false` in case\nthe service which is calling the API has been disabled by the user.",
        "responses": {
          "200": {
            "description": "Found.",
            "schema": {
              "$ref": "#/definitions/LimitedProfile"
            },
            "examples": {
              "application/json": {
                "email": "foobar@example.com",
                "version": 1
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "No user found for the provided fiscal code.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          }
        },
        "parameters": [
          {
            "name": "payload",
            "in": "body",
            "schema": {
              "$ref": "#/definitions/FiscalCodePayload"
            }
          }
        ]
      }
    },
    "/profiles/{fiscal_code}": {
      "get": {
        "operationId": "getProfile",
        "summary": "Get a User Profile",
        "description": "Returns the preferences for the user identified by the provided\nfiscal code. The field `sender_allowed` is set fo `false` in case\nthe service which is calling the API has been disabled by the user.",
        "responses": {
          "200": {
            "description": "Found.",
            "schema": {
              "$ref": "#/definitions/LimitedProfile"
            },
            "examples": {
              "application/json": {
                "email": "foobar@example.com",
                "version": 1
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "No user found for the provided fiscal code.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          }
        },
        "parameters": [
          {
            "$ref": "#/parameters/FiscalCode"
          }
        ]
      }
    },
    "/subscriptions-feed/{date}": {
      "get": {
        "operationId": "getSubscriptionsFeedForDate",
        "summary": "Get Subscriptions Feed",
        "description": "Returns the **hashed fiscal codes** of users that **subscribed to** or\n**unsubscribed from** your service **on the provided date** (UTC).\n\nBy querying this feed everyday, you will be able to retrieve the\n\"delta\" of users that subscribed and unsubscribed from your service.\nYou will have to keep a list of users somewhere in your infrastructure\nthat you will keep updated at all times by adding the subscribed users and\nremoving the unsubscribed users.\n\nYou will then be able to query this local list to know which users you\ncan send messages, to without having to query `getProfile` for each message.\n\nTo avoid sharing the citizens fiscal codes, the API will\nprovide the hex encoding of the SHA256 hash of the upper case fiscal code.\nIn pseudo code `CF_HASH = LOWERCASE(HEX(SHA256(UPPERCASE(CF))))`.\n\nAccess to this feed is subject to case-by-case authorization, and it is\nprimarily intended for large-scale services, such as those pertaining\nto organizations that have an extensive user base (including geographically),\nand/or need to send very high volumes of messages per day.\n\nThis feed serves the purpose of minimizing data processing activities\nwhile preserving optimization of API calls and data accuracy.\nOrganizations allowed are required to query this feed everyday.",
        "responses": {
          "200": {
            "description": "Found.",
            "schema": {
              "$ref": "#/definitions/SubscriptionsFeed"
            },
            "examples": {
              "application/json": {
                "dateUTC": "2019-09-03",
                "subscriptions": [
                  "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
                ],
                "unsubscriptions": []
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "Subscriptions feed not available yet.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          }
        },
        "parameters": [
          {
            "$ref": "#/parameters/DateUTC"
          }
        ]
      }
    },
    "/organizations/{organization_fiscal_code}/logo": {
      "parameters": [
        {
          "$ref": "#/parameters/OrganizationFiscalCode"
        }
      ],
      "put": {
        "summary": "Upload organization logo.",
        "description": "Upsert a logo for an Organization.\n",
        "operationId": "uploadOrganizationLogo",
        "parameters": [
          {
            "name": "body",
            "in": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Logo"
            },
            "description": "A base64 string representation of the organization logo PNG image."
          }
        ],
        "responses": {
          "202": {
            "description": "Logo uploaded."
          },
          "400": {
            "description": "Invalid payload.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "401": {
            "description": "Unauthorized."
          },
          "403": {
            "description": "Forbidden."
          },
          "429": {
            "description": "Too many requests."
          },
          "500": {
            "description": "The organization logo cannot be uploaded.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/activations/": {
      "post": {
        "operationId": "getServiceActivationByPOST",
        "summary": "Get a Service Activation for a User",
        "description": "Returns the current Activation for a couple Service/User",
        "responses": {
          "200": {
            "description": "Found.",
            "schema": {
              "$ref": "#/definitions/Activation"
            },
            "examples": {
              "application/json": {
                "serviceId": "AAAAAAAAAAAAAAA",
                "fiscalCode": "AAAAAA00B00C000D",
                "status": "ACTIVE",
                "version": 1
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "No user activation found for the provided fiscal code.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Internal server error retrieving the Activation",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "parameters": [
          {
            "name": "payload",
            "in": "body",
            "schema": {
              "$ref": "#/definitions/FiscalCodePayload"
            }
          }
        ]
      },
      "put": {
        "operationId": "upsertServiceActivation",
        "summary": "Upsert a Service Activation for a User",
        "description": "Create or update an Activation for a couple Service/User",
        "responses": {
          "200": {
            "description": "Found.",
            "schema": {
              "$ref": "#/definitions/Activation"
            },
            "examples": {
              "application/json": {
                "serviceId": "AAAAAAAAAAAAAAA",
                "fiscalCode": "AAAAAA00B00C000D",
                "status": "ACTIVE",
                "version": 1
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "No user activation found for the provided fiscal code.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "The activation cannot be created or updated",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "parameters": [
          {
            "name": "payload",
            "in": "body",
            "schema": {
              "$ref": "#/definitions/ActivationPayload"
            }
          }
        ]
      }
    }
  },
  "definitions": {
    "ActivationStatus": {
      "type": "string",
      "x-extensible-enum": [
        "ACTIVE",
        "INACTIVE",
        "PENDING"
      ]
    },
    "Activation": {
      "type": "object",
      "properties": {
        "service_id": {
          "$ref": "#/definitions/ServiceId"
        },
        "fiscal_code": {
          "$ref": "#/definitions/FiscalCode"
        },
        "status": {
          "$ref": "#/definitions/ActivationStatus"
        },
        "version": {
          "type": "integer",
          "minimum": 0
        }
      },
      "required": [
        "service_id",
        "fiscal_code",
        "status",
        "version"
      ]
    },
    "ActivationPayload": {
      "type": "object",
      "properties": {
        "fiscal_code": {
          "$ref": "#/definitions/FiscalCode"
        },
        "status": {
          "$ref": "#/definitions/ActivationStatus"
        }
      },
      "required": [
        "fiscal_code",
        "status"
      ]
    },
    "FiscalCodePayload": {
      "type": "object",
      "properties": {
        "fiscal_code": {
          "$ref": "#/definitions/FiscalCode"
        }
      },
      "required": [
        "fiscal_code"
      ]
    },
    "SubscriptionsFeed": {
      "type": "object",
      "properties": {
        "dateUTC": {
          "$ref": "#/definitions/DateUTC"
        },
        "subscriptions": {
          "$ref": "#/definitions/SubscriptionsList"
        },
        "unsubscriptions": {
          "$ref": "#/definitions/SubscriptionsList"
        }
      },
      "required": [
        "dateUTC",
        "subscriptions",
        "unsubscriptions"
      ]
    },
    "SubscriptionsList": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/FiscalCodeHash"
      }
    },
    "FiscalCodeHash": {
      "type": "string",
      "maxLength": 16,
      "minLength": 16,
      "description": "To avoid sharing the citizens fiscal codes, the API will\nprovide the hex encoding of the SHA256 hash of the upper case fiscal code.",
      "pattern": "[0-9a-f]{64}",
      "x-example": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    },
    "DateUTC": {
      "type": "string",
      "maxLength": 10,
      "minLength": 10,
      "description": "A date in the format YYYY-MM-DD.",
      "pattern": "[0-9]{4}-[0-9]{2}-[0-9]{2}",
      "x-example": "2019-09-15"
    },
    "ProblemJson": {
      "type": "object",
      "properties": {
        "type": {
          "type": "string",
          "format": "uri",
          "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
          "default": "about:blank",
          "example": "https://example.com/problem/constraint-violation"
        },
        "title": {
          "type": "string",
          "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
        },
        "status": {
          "type": "integer",
          "format": "int32",
          "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
          "minimum": 100,
          "maximum": 600,
          "exclusiveMaximum": true,
          "example": 200
        },
        "detail": {
          "type": "string",
          "description": "A human readable explanation specific to this occurrence of the\nproblem.",
          "example": "There was an error processing the request"
        },
        "instance": {
          "type": "string",
          "format": "uri",
          "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
        }
      }
    },
    "NotificationChannelStatusValue": {
      "type": "string",
      "description": "The status of a notification (one for each channel).\n\"SENT\": the notification was succesfully sent to the channel (ie. email or push notification)\n\"THROTTLED\": a temporary failure caused a retry during the notification processing;\n  the notification associated with this channel will be delayed for a maximum of 7 days or until the message expires\n\"EXPIRED\": the message expired before the notification could be sent;\n  this means that the maximum message time to live was reached; no notification will be sent to this channel\n\"FAILED\": a permanent failure caused the process to exit with an error, no notification will be sent to this channel",
      "x-extensible-enum": [
        "SENT",
        "THROTTLED",
        "EXPIRED",
        "FAILED"
      ],
      "example": "SENT"
    },
    "MessageResponseWithContent": {
      "type": "object",
      "properties": {
        "message": {
          "$ref": "#/definitions/CreatedMessageWithContent"
        },
        "notification": {
          "$ref": "#/definitions/MessageResponseNotificationStatus"
        },
        "status": {
          "$ref": "#/definitions/MessageStatusValue"
        }
      },
      "required": [
        "message"
      ]
    },
    "ExternalMessageResponseWithContent": {
      "type": "object",
      "properties": {
        "message": {
          "$ref": "#/definitions/ExternalCreatedMessageWithContent"
        },
        "notification": {
          "$ref": "#/definitions/MessageResponseNotificationStatus"
        },
        "status": {
          "$ref": "#/definitions/MessageStatusValue"
        },
        "read_status": {
          "$ref": "#/definitions/ReadStatus",
          "description": "Describes whether a user has read the message or not\nNOTE  : This value is only available for ADVANCED messages\nNOTE 2: `UNAVAILABLE` will be returned if user revoked the permission to access to read status"
        },
        "payment_status": {
          "$ref": "#/definitions/PaymentStatus",
          "description": "Describes the state of the related payment notice\nNOTE: This value is only available for ADVANCED payment messages"
        }
      },
      "required": [
        "message"
      ]
    },
    "MessageResponseNotificationStatus": {
      "type": "object",
      "properties": {
        "email": {
          "$ref": "#/definitions/NotificationChannelStatusValue"
        },
        "webhook": {
          "$ref": "#/definitions/NotificationChannelStatusValue"
        }
      }
    },
    "RejectedMessageStatusValue": {
      "type": "string",
      "x-extensible-enum": [
        "REJECTED"
      ]
    },
    "NotRejectedMessageStatusValue": {
      "type": "string",
      "x-extensible-enum": [
        "ACCEPTED",
        "THROTTLED",
        "FAILED",
        "PROCESSED"
      ]
    },
    "MessageStatusValue": {
      "x-one-of": true,
      "allOf": [
        {
          "$ref": "#/definitions/RejectedMessageStatusValue"
        },
        {
          "$ref": "#/definitions/NotRejectedMessageStatusValue"
        }
      ],
      "description": "The processing status of a message.\n\"ACCEPTED\": the message has been accepted and will be processed for delivery;\n  we'll try to store its content in the user's inbox and notify him on his preferred channels\n\"THROTTLED\": a temporary failure caused a retry during the message processing;\n  any notification associated with this message will be delayed for a maximum of 7 days\n\"FAILED\": a permanent failure caused the process to exit with an error, no notification will be sent for this message\n\"PROCESSED\": the message was succesfully processed and is now stored in the user's inbox;\n  we'll try to send a notification for each of the selected channels\n\"REJECTED\": either the recipient does not exist, or the sender has been blocked"
    },
    "ExternalCreatedMessageWithContent": {
      "allOf": [
        {
          "$ref": "#/definitions/CreatedMessageWithContent"
        },
        {
          "type": "object",
          "properties": {
            "feature_level_type": {
              "$ref": "#/definitions/FeatureLevelType"
            }
          },
          "required": [
            "feature_level_type"
          ]
        }
      ]
    },
    "CreatedMessageWithContent": {
      "type": "object",
      "properties": {
        "id": {
          "type": "string"
        },
        "fiscal_code": {
          "$ref": "#/definitions/FiscalCode"
        },
        "time_to_live": {
          "$ref": "#/definitions/TimeToLiveSeconds"
        },
        "created_at": {
          "$ref": "#/definitions/Timestamp"
        },
        "content": {
          "$ref": "#/definitions/NewMessageContent"
        },
        "sender_service_id": {
          "$ref": "#/definitions/ServiceId"
        }
      },
      "required": [
        "id",
        "fiscal_code",
        "created_at",
        "content",
        "sender_service_id"
      ]
    },
    "EUCovidCert": {
      "type": "object",
      "description": "Paylod with access token to retrieve a EU Covid Certificate",
      "properties": {
        "auth_code": {
          "type": "string"
        }
      },
      "required": [
        "auth_code"
      ]
    },
    "ThirdPartyData": {
      "type": "object",
      "description": "Payload containing all information needed to retrieve and visualize third party message details",
      "properties": {
        "id": {
          "type": "string",
          "description": "Unique id for retrieving third party enriched information about the message",
          "minLength": 1
        },
        "original_sender": {
          "type": "string",
          "description": "Either a ServiceId or a simple string representing the sender name",
          "minLength": 1
        },
        "original_receipt_date": {
          "$ref": "#/definitions/Timestamp"
        },
        "has_attachments": {
          "type": "boolean",
          "default": false
        },
        "has_precondition": {
          "type": "string",
          "x-extensible-enum": [
            "ALWAYS",
            "ONCE",
            "NEVER"
          ]
        },
        "summary": {
          "type": "string",
          "minLength": 1
        }
      },
      "required": [
        "id"
      ]
    },
    "OrganizationFiscalCode": {
      "type": "string",
      "description": "Organization fiscal code.",
      "format": "OrganizationFiscalCode",
      "x-import": "@pagopa/ts-commons/lib/strings",
      "example": "12345678901"
    },
    "FiscalCode": {
      "type": "string",
      "description": "User's fiscal code.",
      "format": "FiscalCode",
      "x-import": "@pagopa/ts-commons/lib/strings",
      "example": "SPNDNL80R13C555X"
    },
    "LimitedProfile": {
      "description": "Describes the citizen's profile, mostly interesting for preferences\nattributes.",
      "type": "object",
      "properties": {
        "sender_allowed": {
          "type": "boolean",
          "description": "True in case the service that made the request can send\nmessages to the user identified by this profile (false otherwise)."
        },
        "preferred_languages": {
          "type": "array",
          "items": {
            "type": "string",
            "x-extensible-enum": [
              "it_IT",
              "en_GB",
              "es_ES",
              "de_DE",
              "fr_FR"
            ],
            "example": "it_IT"
          },
          "description": "Indicates the User's preferred written or spoken languages in order\nof preference. Generally used for selecting a localized User interface. Valid\nvalues are concatenation of the ISO 639-1 two letter language code, an underscore,\nand the ISO 3166-1 2 letter country code; e.g., 'en_US' specifies the language\nEnglish and country US."
        }
      },
      "required": [
        "sender_allowed"
      ]
    },
    "Timestamp": {
      "type": "string",
      "format": "UTCISODateFromString",
      "description": "A date-time field in ISO-8601 format and UTC timezone.",
      "x-import": "@pagopa/ts-commons/lib/dates",
      "example": "2018-10-13T00:00:00.000Z"
    },
    "TimeToLiveSeconds": {
      "type": "integer",
      "default": 3600,
      "minimum": 3600,
      "maximum": 604800,
      "description": "This parameter specifies for how long (in seconds) the system will\ntry to deliver the message to the channels configured by the user.",
      "example": 3600
    },
    "PrescriptionData": {
      "type": "object",
      "description": "Metadata needed to process medical prescriptions.",
      "properties": {
        "nre": {
          "$ref": "#/definitions/PrescriptionNRE"
        },
        "iup": {
          "$ref": "#/definitions/PrescriptionIUP"
        },
        "prescriber_fiscal_code": {
          "$ref": "#/definitions/PrescriberFiscalCode"
        }
      },
      "required": [
        "nre"
      ]
    },
    "PrescriptionNRE": {
      "description": "The field *Numero ricetta elettronica* identifies the medical prescription at national level.",
      "type": "string",
      "minLength": 15,
      "maxLength": 15
    },
    "PrescriptionIUP": {
      "description": "The field *Identificativo Unico di Prescrizione* identifies the medical prescription at regional level.",
      "type": "string",
      "minLength": 1,
      "maxLength": 16
    },
    "PrescriberFiscalCode": {
      "type": "string",
      "description": "Fiscal code of the Doctor that made the prescription.",
      "format": "FiscalCode",
      "x-import": "@pagopa/ts-commons/lib/strings",
      "example": "TCNZRO80R13C555Y"
    },
    "MessageContentBase": {
      "type": "object",
      "properties": {
        "subject": {
          "type": "string",
          "description": "The (optional) subject of the message - note that only some notification\nchannels support the display of a subject. When a subject is not provided,\none gets generated from the client attributes.",
          "minLength": 10,
          "maxLength": 120,
          "example": "Welcome new user !"
        },
        "markdown": {
          "type": "string",
          "description": "The full version of the message, in plain text or Markdown format. The\ncontent of this field will be delivered to channels that don't have any\nlimit in terms of content size (e.g. email, etc...).",
          "minLength": 80,
          "maxLength": 10000,
          "example": "# This is a markdown header\n\nto show how easily markdown can be converted to **HTML**\n\nRemember: this has to be a long text."
        },
        "require_secure_channels": {
          "type": "boolean",
          "description": "When true, messages won't trigger email notifications (only push)."
        }
      },
      "required": [
        "subject",
        "markdown"
      ]
    },
    "MessageContent": {
      "allOf": [
        {
          "$ref": "#/definitions/MessageContentBase"
        },
        {
          "type": "object",
          "properties": {
            "payment_data": {
              "$ref": "#/definitions/PaymentData"
            },
            "prescription_data": {
              "$ref": "#/definitions/PrescriptionData"
            },
            "legal_data": {
              "$ref": "#/definitions/LegalData"
            },
            "eu_covid_cert": {
              "$ref": "#/definitions/EUCovidCert"
            },
            "third_party_data": {
              "$ref": "#/definitions/ThirdPartyData"
            },
            "due_date": {
              "$ref": "#/definitions/Timestamp"
            }
          }
        }
      ]
    },
    "NewMessageContent": {
      "allOf": [
        {
          "$ref": "#/definitions/MessageContentBase"
        },
        {
          "type": "object",
          "properties": {
            "payment_data": {
              "$ref": "#/definitions/PaymentDataWithRequiredPayee"
            },
            "due_date": {
              "$ref": "#/definitions/Timestamp"
            },
            "prescription_data": {
              "$ref": "#/definitions/PrescriptionData"
            },
            "eu_covid_cert": {
              "$ref": "#/definitions/EUCovidCert"
            },
            "third_party_data": {
              "$ref": "#/definitions/ThirdPartyData"
            },
            "legal_data": {
              "$ref": "#/definitions/LegalData"
            }
          }
        }
      ]
    },
    "NewMessage": {
      "type": "object",
      "properties": {
        "time_to_live": {
          "$ref": "#/definitions/TimeToLiveSeconds"
        },
        "content": {
          "$ref": "#/definitions/MessageContent"
        },
        "default_addresses": {
          "type": "object",
          "description": "Default addresses for notifying the recipient of the message in case\nno address for the related channel is set in his profile.",
          "properties": {
            "email": {
              "type": "string",
              "format": "email",
              "example": "foobar@example.com"
            }
          }
        },
        "fiscal_code": {
          "$ref": "#/definitions/FiscalCode"
        },
        "feature_level_type": {
          "$ref": "#/definitions/FeatureLevelType"
        }
      },
      "required": [
        "content"
      ]
    },
    "FeatureLevelType": {
      "type": "string",
      "default": "STANDARD",
      "x-extensible-enum": [
        "STANDARD",
        "ADVANCED"
      ],
      "example": "STANDARD"
    },
    "ReadStatus": {
      "type": "string",
      "x-extensible-enum": [
        "UNAVAILABLE",
        "UNREAD",
        "READ"
      ],
      "example": "UNREAD",
      "description": "Api definition of read status enumeration"
    },
    "PaymentStatus": {
      "type": "string",
      "description": "Payment status enumeration",
      "x-extensible-enum": [
        "PAID",
        "NOT_PAID"
      ],
      "example": "NOT_PAID"
    },
    "CIDR": {
      "type": "string",
      "description": "Describes a single IP or a range of IPs.",
      "pattern": "^([0-9]{1,3}[.]){3}[0-9]{1,3}(/([0-9]|[1-2][0-9]|3[0-2]))?$"
    },
    "ServicePayload": {
      "description": "A payload used to create/update a service for a user.",
      "x-one-of": true,
      "allOf": [
        {
          "$ref": "#/definitions/VisibleServicePayload"
        },
        {
          "$ref": "#/definitions/HiddenServicePayload"
        }
      ]
    },
    "HiddenServicePayload": {
      "description": "A payload used to create/update a service that is hidden.",
      "allOf": [
        {
          "$ref": "#/definitions/CommonServicePayload"
        },
        {
          "type": "object",
          "properties": {
            "is_visible": {
              "type": "boolean",
              "default": false,
              "enum": [
                false
              ],
              "description": "It indicates that service is hidden"
            },
            "service_metadata": {
              "description": "That service can't handle some ServiceMetadata fields (es. category)",
              "$ref": "#/definitions/CommonServiceMetadata"
            }
          }
        }
      ]
    },
    "VisibleServicePayload": {
      "description": "A payload used to create/update a service that appears in the service list.",
      "allOf": [
        {
          "$ref": "#/definitions/CommonServicePayload"
        },
        {
          "type": "object",
          "properties": {
            "is_visible": {
              "type": "boolean",
              "enum": [
                true
              ],
              "description": "It indicates that service appears in the service list"
            },
            "service_metadata": {
              "description": "That service can't handle some ServiceMetadata fields (es. category)",
              "$ref": "#/definitions/CommonServiceMetadata"
            }
          },
          "required": [
            "is_visible",
            "service_metadata"
          ]
        }
      ]
    },
    "ExtendedServicePayload": {
      "allOf": [
        {
          "$ref": "#/definitions/ServicePayload"
        },
        {
          "type": "object",
          "properties": {
            "service_metadata": {
              "$ref": "#/definitions/ServiceMetadata"
            }
          }
        }
      ]
    },
    "CommonServicePayload": {
      "description": "Common properties for a ServicePayload",
      "type": "object",
      "properties": {
        "service_name": {
          "$ref": "#/definitions/ServiceName"
        },
        "department_name": {
          "$ref": "#/definitions/DepartmentName"
        },
        "organization_name": {
          "$ref": "#/definitions/OrganizationName"
        },
        "organization_fiscal_code": {
          "$ref": "#/definitions/OrganizationFiscalCode"
        },
        "authorized_cidrs": {
          "description": "Allowed source IPs or CIDRs for this service.\nWhen empty, every IP address it's authorized to call the IO API on behalf of the service.",
          "type": "array",
          "items": {
            "$ref": "#/definitions/CIDR"
          }
        },
        "version": {
          "type": "integer"
        },
        "require_secure_channels": {
          "type": "boolean",
          "default": false,
          "description": "When true, messages won't trigger email notifications (only push)."
        }
      },
      "required": [
        "service_name",
        "department_name",
        "organization_name",
        "organization_fiscal_code",
        "authorized_cidrs"
      ]
    },
    "Service": {
      "description": "A service tied to user's subscription.",
      "allOf": [
        {
          "$ref": "#/definitions/ExtendedServicePayload"
        },
        {
          "type": "object",
          "properties": {
            "id": {
              "type": "string"
            },
            "service_id": {
              "$ref": "#/definitions/ServiceId"
            },
            "authorized_recipients": {
              "description": "If non empty, the service will be able\nto send messages only to these fiscal codes.",
              "type": "array",
              "items": {
                "$ref": "#/definitions/FiscalCode"
              }
            },
            "max_allowed_payment_amount": {
              "description": "Maximum amount in euro cents that a service is allowed to charge to a user.",
              "type": "integer",
              "minimum": 0,
              "maximum": 9999999999,
              "default": 0
            }
          },
          "required": [
            "service_id",
            "authorized_recipients"
          ]
        }
      ]
    },
    "ServiceMetadata": {
      "x-one-of": true,
      "allOf": [
        {
          "$ref": "#/definitions/StandardServiceMetadata"
        },
        {
          "$ref": "#/definitions/SpecialServiceMetadata"
        },
        {
          "$ref": "#/definitions/CommonServiceMetadata"
        }
      ]
    },
    "StandardServiceMetadata": {
      "allOf": [
        {
          "$ref": "#/definitions/CommonServiceMetadata"
        },
        {
          "type": "object",
          "properties": {
            "category": {
              "type": "string",
              "x-extensible-enum": [
                "STANDARD"
              ]
            }
          },
          "required": [
            "category"
          ]
        }
      ]
    },
    "SpecialServiceMetadata": {
      "allOf": [
        {
          "$ref": "#/definitions/CommonServiceMetadata"
        },
        {
          "type": "object",
          "properties": {
            "category": {
              "type": "string",
              "x-extensible-enum": [
                "SPECIAL"
              ]
            },
            "custom_special_flow": {
              "type": "string",
              "minLength": 1
            }
          },
          "required": [
            "category"
          ]
        }
      ]
    },
    "CommonServiceMetadata": {
      "type": "object",
      "description": "A set of metadata properties related to this service.",
      "properties": {
        "description": {
          "type": "string",
          "minLength": 1
        },
        "web_url": {
          "type": "string",
          "minLength": 1
        },
        "app_ios": {
          "type": "string",
          "minLength": 1
        },
        "app_android": {
          "type": "string",
          "minLength": 1
        },
        "tos_url": {
          "type": "string",
          "minLength": 1
        },
        "privacy_url": {
          "type": "string",
          "minLength": 1
        },
        "address": {
          "type": "string",
          "minLength": 1
        },
        "phone": {
          "type": "string",
          "minLength": 1
        },
        "email": {
          "type": "string",
          "minLength": 1
        },
        "pec": {
          "type": "string",
          "minLength": 1
        },
        "cta": {
          "type": "string",
          "minLength": 1
        },
        "token_name": {
          "type": "string",
          "minLength": 1
        },
        "support_url": {
          "type": "string",
          "minLength": 1
        },
        "scope": {
          "$ref": "#/definitions/ServiceScope"
        }
      },
      "required": [
        "scope"
      ]
    },
    "ServiceScope": {
      "type": "string",
      "x-extensible-enum": [
        "NATIONAL",
        "LOCAL"
      ]
    },
    "ServiceId": {
      "type": "string",
      "description": "The ID of the Service. Equals the subscriptionId of a registered\nAPI user.",
      "minLength": 1
    },
    "ServiceName": {
      "type": "string",
      "description": "The name of the service. Will be added to the content of sent messages.",
      "minLength": 1
    },
    "OrganizationName": {
      "type": "string",
      "description": "The organization that runs the service. Will be added to the content\nof sent messages to identify the sender.",
      "minLength": 1
    },
    "DepartmentName": {
      "type": "string",
      "description": "The department inside the organization that runs the service. Will\nbe added to the content of sent messages.",
      "minLength": 1
    },
    "PaymentDataBase": {
      "type": "object",
      "description": "Metadata needed to process pagoPA payments.",
      "properties": {
        "amount": {
          "description": "Amount of payment in euro cent. PagoPA accepts up to 9999999999 euro cents.",
          "type": "integer",
          "minimum": 1,
          "maximum": 9999999999
        },
        "notice_number": {
          "description": "The field [\"Numero Avviso\"](https://pagopa-specifichepagamenti.readthedocs.io/it/latest/_docs/Capitolo7.html#il-numero-avviso-e-larchivio-dei-pagamenti-in-attesa) of pagoPa, needed to identify the payment. Format is `<aux digit (1n)>[<application code> (2n)]<codice IUV (15|17n)>`. See [pagoPa specs](https://www.agid.gov.it/sites/default/files/repository_files/specifiche_attuative_pagamenti_1_3_1_0.pdf) for more info on this field and the IUV.",
          "type": "string",
          "pattern": "^[0123][0-9]{17}$"
        },
        "invalid_after_due_date": {
          "type": "boolean",
          "default": false
        }
      },
      "required": [
        "amount",
        "notice_number"
      ]
    },
    "PaymentData": {
      "allOf": [
        {
          "$ref": "#/definitions/PaymentDataBase"
        },
        {
          "type": "object",
          "properties": {
            "payee": {
              "$ref": "#/definitions/Payee"
            }
          }
        }
      ]
    },
    "Payee": {
      "type": "object",
      "description": "Metadata needed to explicit payment's payee.",
      "properties": {
        "fiscal_code": {
          "$ref": "#/definitions/OrganizationFiscalCode"
        }
      },
      "required": [
        "fiscal_code"
      ]
    },
    "PaymentDataWithRequiredPayee": {
      "allOf": [
        {
          "$ref": "#/definitions/PaymentDataBase"
        },
        {
          "type": "object",
          "properties": {
            "payee": {
              "$ref": "#/definitions/Payee"
            }
          },
          "required": [
            "payee"
          ]
        }
      ]
    },
    "LegalData": {
      "type": "object",
      "properties": {
        "sender_mail_from": {
          "type": "string",
          "minLength": 1
        },
        "has_attachment": {
          "type": "boolean",
          "default": false
        },
        "message_unique_id": {
          "type": "string",
          "minLength": 1
        },
        "original_message_url": {
          "type": "string",
          "minLength": 1
        },
        "pec_server_service_id": {
          "$ref": "#/definitions/ServiceId"
        }
      },
      "required": [
        "sender_mail_from",
        "has_attachment",
        "message_unique_id"
      ]
    },
    "SubscriptionKeys": {
      "type": "object",
      "properties": {
        "primary_key": {
          "type": "string"
        },
        "secondary_key": {
          "type": "string"
        }
      },
      "required": [
        "primary_key",
        "secondary_key"
      ]
    },
    "ServiceWithSubscriptionKeys": {
      "allOf": [
        {
          "$ref": "#/definitions/Service"
        },
        {
          "$ref": "#/definitions/SubscriptionKeys"
        }
      ]
    },
    "ServiceIdCollection": {
      "type": "object",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/ServiceId"
          }
        }
      },
      "required": [
        "items"
      ]
    },
    "Logo": {
      "type": "object",
      "properties": {
        "logo": {
          "type": "string",
          "format": "byte",
          "minLength": 1
        }
      },
      "required": [
        "logo"
      ]
    },
    "SubscriptionKeyTypePayload": {
      "type": "object",
      "properties": {
        "key_type": {
          "$ref": "#/definitions/SubscriptionKeyType"
        }
      },
      "required": [
        "key_type"
      ]
    },
    "SubscriptionKeyType": {
      "type": "string",
      "x-extensible-enum": [
        "PRIMARY_KEY",
        "SECONDARY_KEY"
      ]
    },
    "CreatedMessage": {
      "type": "object",
      "properties": {
        "id": {
          "type": "string",
          "description": "The identifier of the created message."
        }
      }
    }
  },
  "responses": {},
  "parameters": {
    "LegalMail": {
      "name": "legalmail",
      "in": "path",
      "type": "string",
      "required": true,
      "description": "The legal mail related to a legal message' s sender.",
      "format": "EmailString",
      "x-example": "demo@pec.it",
      "x-import": "italia-ts-commons/lib/strings"
    },
    "FiscalCode": {
      "name": "fiscal_code",
      "in": "path",
      "type": "string",
      "maxLength": 16,
      "minLength": 16,
      "required": true,
      "description": "The fiscal code of the user, all upper case.",
      "pattern": "[A-Z]{6}[0-9LMNPQRSTUV]{2}[ABCDEHLMPRST][0-9LMNPQRSTUV]{2}[A-Z][0-9LMNPQRSTUV]{3}[A-Z]",
      "x-example": "SPNDNL80R13C555X"
    },
    "DateUTC": {
      "name": "date",
      "in": "path",
      "type": "string",
      "maxLength": 10,
      "minLength": 10,
      "required": true,
      "description": "A date in the format YYYY-MM-DD.",
      "pattern": "[0-9]{4}-[0-9]{2}-[0-9]{2}",
      "x-example": "2019-09-15"
    },
    "OrganizationFiscalCode": {
      "name": "organization_fiscal_code",
      "in": "path",
      "type": "string",
      "required": true,
      "description": "Organization fiscal code.",
      "format": "OrganizationFiscalCode",
      "x-import": "italia-ts-commons/lib/strings"
    }
  },
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ],
  "securityDefinitions": {
    "SubscriptionKey": {
      "type": "apiKey",
      "name": "Ocp-Apim-Subscription-Key",
      "in": "header",
      "description": "The API key obtained through the Backoffice IO or both getService or cmsGetServiceKeys operation."
    },
    "ManageSubscriptionKey": {
      "type": "apiKey",
      "name": "Ocp-Apim-Subscription-Key",
      "in": "header",
      "description": "The `manage` API key obtained through the Backoffice IO."
    }
  }
}
