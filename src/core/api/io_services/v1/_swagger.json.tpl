{
  "swagger": "2.0",
  "info": {
    "version": "3.3.1",
    "title": "IO API for Public Administration Services",
    "contact": {
      "name": "PagoPA S.p.A",
      "url": "https://pagopa.it"
    },
    "x-logo": {
      "url": "https://io.italia.it/assets/img/io-logo-blue.svg"
    },
    "description": "This is the specification of the API to integrate 3rd party services into [IO app](https://io.italia.it/). This API enables Public Administration services to integrate with the IO platform. IO enables services to communicate with Italian citizens via the [IO app](https://io.italia.it/).\n\nFurther informations about how to join the platform, technical documentation, tutorial and examples can be found at https://docs.pagopa.it/io-guida-tecnica."
  },
  "host": "${host}", 
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
        "tags": [
          "use"
        ],
        "operationId": "submitMessageforUserWithFiscalCodeInBody",
        "summary": "Submit a Message passing the user fiscal_code in the request body",
        "description": "Submits a message to a user.\nThe simplest message contains subject and markdown as content; additional informations, such as payment data, can be provided to enrich the message. Please refer to https://docs.pagopa.it/io-guida-tecnica for a detailed explanation on how and when using additional content attributes.",
        "parameters": [
          {
            "name": "message",
            "in": "body",
            "schema": {
              "$ref": "#/definitions/NewMessage"
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
        "tags": [
          "use"
        ],
        "operationId": "submitMessageforUser",
        "summary": "Submit a Message passing the user fiscal_code as path parameter",
        "description": "Submits a message to a user.\nThe simplest message contains subject and markdown as content; additional informations, such as payment data, can be provided to enrich the message. Please refer to https://docs.pagopa.it/io-guida-tecnica for a detailed explanation on how and when using additional content attributes.",
        "parameters": [
          {
            "$ref": "#/parameters/FiscalCode"
          },
          {
            "name": "message",
            "in": "body",
            "schema": {
              "$ref": "#/definitions/NewMessage"
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
        "tags": [
          "use"
        ],
        "operationId": "getMessage",
        "summary": "Get Message",
        "description": "The previously created message with the provided message ID is\nreturned.",
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
              "$ref": "#/definitions/MessageResponseWithContent"
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
        "tags": [
          "use"
        ],
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
        "tags": [
          "use"
        ],
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
        "tags": [
          "use"
        ],
        "operationId": "getSubscriptionsFeedForDate",
        "summary": "Get Subscriptions Feed",
        "description": "Returns the **hashed fiscal codes** of users that **subscribed to** or\n**unsubscribed from** your service **on the provided date** (UTC).\n\nBy querying this feed on each day, you will be able to retrieve the\n\"delta\" of users that subscribed and unsubscribed fom your service.\nYou will have to keep a list of users somewhere in your infrastructure\nthat you will update each day by adding the subscribed users and\nremoving the unsunbscribed users.\n\nYou will then be able to query this local list to know which users you\ncan send messages, to without having to query `getProfile` for each message.\n\nTo avoid sharing the citizens fiscal codes, the API will\nprovide the hex encoding of the SHA256 hash of the upper case fiscal code.\nIn pseudo code `CF_HASH = LOWERCASE(HEX(SHA256(UPPERCASE(CF))))`.\n\nNote that this is an optimization for those services that need to send very high\nvolumes of messages per day, to avoid having to make two API calls for each message.",
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
    "/services": {
      "post": {
        "tags": [
          "manage"
        ],
        "operationId": "createService",
        "summary": "Create Service",
        "description": "Create a new Service with the attributes provided in the request payload.\n",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "description": "A service can invoke the IO API by providing the relative API key\n(every service has an associated primary and secondary API key).\nThrough the API a service can send messages to the IO users\nthat haven't opted out from it. Service metadata are used\nto qualify the sender of these messages to the recipient.",
            "schema": {
              "$ref": "#/definitions/ServicePayload"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Service created.",
            "schema": {
              "$ref": "#/definitions/ServiceWithSubscriptionKeys"
            }
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
            "description": "The service cannot be created.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      },
      "get": {
        "tags": [
          "manage"
        ],
        "operationId": "getUserServices",
        "summary": "Get User Services",
        "description": "Retrieve the identifiers of the services owned by the calling user\n",
        "responses": {
          "200": {
            "description": "The list of service ids.",
            "schema": {
              "$ref": "#/definitions/ServiceIdCollection"
            }
          },
          "401": {
            "description": "Unauthorized."
          },
          "429": {
            "description": "Too many requests."
          }
        }
      }
    },
    "/services/{service_id}": {
      "parameters": [
        {
          "name": "service_id",
          "in": "path",
          "type": "string",
          "required": true,
          "description": "The ID of an existing Service."
        }
      ],
      "get": {
        "tags": [
          "manage"
        ],
        "operationId": "getService",
        "summary": "Get Service",
        "description": "Retrieve a previously created service with the provided service ID.\nThis API operation needs the same API key of the service being retrieved\notherwise 403 forbidden will be returned to the caller.\n",
        "responses": {
          "200": {
            "description": "Service found.",
            "schema": {
              "$ref": "#/definitions/ServiceWithSubscriptionKeys"
            }
          },
          "401": {
            "description": "Unauthorized."
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "No service found for the provided ID."
          },
          "429": {
            "description": "Too many requests."
          }
        }
      },
      "put": {
        "tags": [
          "manage"
        ],
        "operationId": "updateService",
        "summary": "Update Service",
        "description": "Update a previously created service with the provided service ID\nThis API operation needs the same API key of the service being retrieved\notherwise 403 forbidden will be returned to the caller.",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "description": "The updated service payload.",
            "schema": {
              "$ref": "#/definitions/ServicePayload"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Service updated.",
            "schema": {
              "$ref": "#/definitions/ServiceWithSubscriptionKeys"
            }
          },
          "401": {
            "description": "Unauthorized."
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "No service found for the provided ID."
          },
          "429": {
            "description": "Too many requests."
          },
          "500": {
            "description": "The service cannot be updated.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/services/{service_id}/logo": {
      "parameters": [
        {
          "name": "service_id",
          "in": "path",
          "type": "string",
          "required": true,
          "description": "The ID of an existing Service."
        }
      ],
      "put": {
        "tags": [
          "manage"
        ],
        "summary": "Upload service logo.",
        "description": "Upsert a logo for an existing service.\nThis API operation needs the same API key of the service being retrieved\notherwise 403 forbidden will be returned to the caller.\n",
        "operationId": "uploadServiceLogo",
        "parameters": [
          {
            "name": "body",
            "in": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Logo"
            },
            "description": "A base64 string representation of the service logo PNG image. It can be the service own logo or the organization logo."
          }
        ],
        "responses": {
          "200": {
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
          "404": {
            "description": "No service found for the provided ID."
          },
          "500": {
            "description": "The service logo cannot be uploaded.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/services/{service_id}/keys": {
      "put": {
        "tags": [
          "manage"
        ],
        "summary": "Regenerate Service Key",
        "description": "Regenerate the specified key for the Service identified by the provided id.\nThis API operation needs the same API key of the service being retrieved\notherwise 403 forbidden will be returned to the caller.",
        "operationId": "regenerateServiceKey",
        "parameters": [
          {
            "name": "service_id",
            "in": "path",
            "type": "string",
            "required": true,
            "description": "The ID of an existing Service."
          },
          {
            "name": "body",
            "in": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/SubscriptionKeyTypePayload"
            },
            "description": "The type of the key to be regenerated (PRIMARY_KEY or SECONDARY_KEY)."
          }
        ],
        "responses": {
          "200": {
            "description": "The subscription keys for the service.",
            "schema": {
              "$ref": "#/definitions/SubscriptionKeys"
            }
          },
          "400": {
            "description": "Invalid payload.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "403": {
            "description": "Forbidden."
          },
          "404": {
            "description": "Service not found."
          },
          "500": {
            "description": "Cannot regenerate service key.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/organizations/{organization_fiscal_code}/logo": {
      "parameters": [
        {
          "$ref": "#/parameters/OrganizationFiscalCode"
        }
      ],
      "put": {
        "tags": [
          "manage"
        ],
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
    "/activations": {
      "post": {
        "tags": [
          "use"
        ],
        "operationId": "getServiceActivationByPOST",
        "summary": "Get a Service Activation for a User",
        "description": "Returns the current Activation for a couple Service/User. The operations uses post to not show User's id in the request path.",
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
        "tags": [
          "use"
        ],
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
        "notification": {
          "description": "Whether the user has been notified on its channels",
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
        "status": {
          "type": "string",
          "description": "The processing status of a message.\n\"ACCEPTED\": the message has been accepted and will be processed for delivery;\n  we'll try to store its content in the user's inbox and notify him on his preferred channels\n\"THROTTLED\": a temporary failure caused a retry during the message processing;\n  any notification associated with this message will be delayed for a maximum of 7 days\n\"FAILED\": a permanent failure caused the process to exit with an error, no notification will be sent for this message\n\"PROCESSED\": the message was succesfully processed and is now stored in the user's inbox;\n  we'll try to send a notification for each of the selected channels\n\"REJECTED\": either the recipient does not exist, or the sender has been blocked",
          "x-extensible-enum": [
            "ACCEPTED",
            "THROTTLED",
            "FAILED",
            "PROCESSED",
            "REJECTED"
          ],
          "example": "ACCEPTED"
        }
      },
      "required": [
        "message"
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
        }
      },
      "required": [
        "content"
      ]
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
      },
      "example": {
        "id": "01BX9NSMKVXXS5PSP2FATZMYYY"
      }
    }
  },
  "responses": {},
  "parameters": {
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
      "description": "The API key obtained through the developer portal or the getService operation."
    }
  }
}