{
  "swagger": "2.0",
  "info": {
    "title": "OpenID Provider",
    "description": "OpenID Provider service",
    "version": "0.0.1"
  },
  "host": "api.openid-provider.io.italia.it",
  "schemes": [
    "https"
  ],
  "paths": {
    "fims/admin/clients": {
      "post": {
        "operationId": "createClients",
        "summary": "Create a client",
        "parameters": [
          {
            "in": "body",
            "name": "payload",
            "schema": {
              "type": "object",
              "required": [
                "redirect_uris",
                "organization_id",
                "service_id"
              ],
              "properties": {
                "redirect_uris": {
                  "type": "array",
                  "description": "REQUIRED. Array of Redirection URI values used by the Client. One of these registered Redirection URI values MUST exactly match the redirect_uri parameter value used in each Authorization Request",
                  "items": {
                    "type": "string"
                  }
                },
                "response_types": {
                  "type": "array",
                  "description": "JSON array containing a list of the OAuth 2.0 response_type values that the Client is declaring that it will restrict itself to using. If omitted, the default is that the Client will use only the code Response Type.",
                  "items": {
                    "type": "string",
                    "enum": [
                      "id_token"
                    ]
                  }
                },
                "grant_types": {
                  "type": "array",
                  "description": "JSON array containing a list of the OAuth 2.0 Grant Types that the Client is declaring that it will restrict itself to using. Values used by OpenID Connect are authorization_code, implicit and refresh_token",
                  "items": {
                    "type": "string",
                    "enum": [
                      "implicit"
                    ]
                  }
                },
                "client_name": {
                  "type": "string",
                  "description": "Name of the Client to be presented to the End-User."
                },
                "id_token_signed_response_alg": {
                  "type": "string",
                  "enum": [
                    "RS256"
                  ]
                },
                "scope": {
                  "type": "string",
                  "description": "String containing a space-separated list of scope values"
                },
                "organization_id": {
                  "type": "string",
                  "description": "Organization fiscal code.",
                  "format": "OrganizationFiscalCode",
                  "x-import": "@pagopa/ts-commons/lib/strings",
                  "example": "12345678901"
                },
                "service_id": {
                  "type": "string",
                  "description": "The ID of the Service. Equals the subscriptionId of a registered\nAPI user.",
                  "minLength": 1
                }
              }
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Detail of a client",
            "schema": {
              "allOf": [
                {
                  "$ref": "#/paths/~1admin~1clients/post/parameters/0/schema"
                },
                {
                  "type": "object",
                  "required": [
                    "client_id"
                  ],
                  "properties": {
                    "client_id": {
                      "type": "string",
                      "description": "REQUIRED. Unique Client Identifier. It MUST NOT be currently valid for any other registered Client."
                    },
                    "client_id_issued_at": {
                      "type": "string",
                      "description": "Time at which the Client Identifier was issued. Its value is a JSON number representing the number of seconds from 1970-01-01T0:0:0Z as measured in UTC until the date/time."
                    }
                  }
                }
              ]
            }
          },
          "400": {
            "description": "The given payload is invalid",
            "schema": {
              "type": "object",
              "required": [
                "error"
              ],
              "properties": {
                "error": {
                  "type": "string",
                  "description": "REQUIRED.  A single ASCII [USASCII] error code."
                },
                "error_description": {
                  "type": "string",
                  "description": "OPTIONAL.  Human-readable ASCII [USASCII] text providing additional information, used to assist the client developer in understanding the error that occurred. Values for the \"error_description\" parameter MUST NOT include characters outside the set %x20-21 / %x23-5B / %x5D-7E."
                }
              }
            }
          },
          "401": {
            "$ref": "#/paths/~1admin~1grants/get/responses/401"
          },
          "500": {
            "$ref": "#/paths/~1admin~1grants/get/responses/500"
          }
        }
      },
      "get": {
        "operationId": "getClients",
        "summary": "List clients",
        "parameters": [
          {
            "name": "organizationId",
            "description": "The client organization",
            "in": "query",
            "required": false,
            "type": "string"
          },
          {
            "name": "serviceId",
            "description": "The client service",
            "in": "query",
            "required": false,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "List of clients",
            "schema": {
              "description": "List of provider clients",
              "type": "object",
              "properties": {
                "items": {
                  "type": "array",
                  "items": {
                    "$ref": "#/paths/~1admin~1clients/post/responses/200/schema"
                  }
                }
              },
              "required": [
                "items"
              ]
            }
          },
          "401": {
            "$ref": "#/paths/~1admin~1grants/get/responses/401"
          },
          "500": {
            "$ref": "#/paths/~1admin~1grants/get/responses/500"
          }
        }
      }
    },
    "/admin/clients/{clientId}": {
      "parameters": [
        {
          "name": "clientId",
          "in": "path",
          "required": true,
          "description": "The identifier of a client",
          "type": "string"
        }
      ],
      "get": {
        "operationId": "detailClient",
        "summary": "Return a client details",
        "responses": {
          "200": {
            "$ref": "#/paths/~1admin~1clients/post/responses/200"
          },
          "401": {
            "$ref": "#/paths/~1admin~1grants/get/responses/401"
          },
          "404": {
            "description": "The requested entity is not found",
            "schema": {
              "$ref": "#/paths/~1admin~1grants/get/responses/500/schema"
            }
          },
          "500": {
            "$ref": "#/paths/~1admin~1grants/get/responses/500"
          }
        }
      },
      "delete": {
        "operationId": "deleteClient",
        "summary": "Remove a client",
        "responses": {
          "200": {
            "$ref": "#/paths/~1admin~1clients/post/responses/200"
          },
          "401": {
            "$ref": "#/paths/~1admin~1grants/get/responses/401"
          },
          "404": {
            "$ref": "#/paths/~1admin~1clients~1%7BclientId%7D/get/responses/404"
          },
          "500": {
            "$ref": "#/paths/~1admin~1grants/get/responses/500"
          }
        }
      }
    },
    "/admin/grants": {
      "parameters": [
        {
          "name": "identityId",
          "in": "header",
          "required": true,
          "description": "The identifier of the user",
          "type": "string"
        }
      ],
      "get": {
        "operationId": "listGrant",
        "summary": "Return a list of grant",
        "security": [
          {
            "SubscriptionKey": []
          }
        ],
        "responses": {
          "200": {
            "description": "List of grant",
            "schema": {
              "description": "List of grant",
              "type": "object",
              "properties": {
                "items": {
                  "type": "array",
                  "items": {
                    "$ref": "#/paths/~1admin~1grants~1%7BorganizationId%7D~1%7BserviceId%7D/get/responses/200/schema"
                  }
                }
              },
              "required": [
                "items"
              ]
            }
          },
          "401": {
            "description": "The authorization token is missing or invalid",
            "schema": {
              "type": "string"
            }
          },
          "500": {
            "description": "Unknown error",
            "headers": {
              "Pragma": {
                "description": "Pragma browser directive",
                "type": "string",
                "default": "no-cache"
              },
              "Cache-Control": {
                "description": "Cache-Control browser directive",
                "type": "string",
                "default": "no-store"
              }
            },
            "schema": {
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
            }
          }
        }
      }
    },
    "/admin/grants/{organizationId}/{serviceId}": {
      "parameters": [
        {
          "name": "organizationId",
          "description": "The organization identifier",
          "in": "path",
          "required": true,
          "type": "string"
        },
        {
          "name": "serviceId",
          "description": "The service identifier",
          "in": "path",
          "required": true,
          "type": "string"
        },
        {
          "$ref": "#/paths/~1admin~1grants/parameters/0"
        }
      ],
      "get": {
        "operationId": "detailGrant",
        "summary": "Return a grant detail",
        "security": [
          {
            "SubscriptionKey": []
          }
        ],
        "responses": {
          "200": {
            "description": "Detail of a grant",
            "schema": {
              "type": "object",
              "properties": {
                "id": {
                  "type": "string",
                  "minLength": 1
                },
                "issuedAt": {
                  "type": "string",
                  "format": "date-time"
                },
                "expireAt": {
                  "type": "string",
                  "format": "date-time"
                },
                "organizationId": {
                  "$ref": "#/paths/~1admin~1clients/post/parameters/0/schema/properties/organization_id"
                },
                "serviceId": {
                  "$ref": "#/paths/~1admin~1clients/post/parameters/0/schema/properties/service_id"
                },
                "identityId": {
                  "type": "string",
                  "description": "User's fiscal code.",
                  "format": "FiscalCode",
                  "x-import": "@pagopa/ts-commons/lib/strings",
                  "example": "SPNDNL80R13C555X"
                },
                "scope": {
                  "type": "array",
                  "description": "The scope the user granted to the client, at the moment the values could be:\n  acr, auth_time, date_of_birth, email_verified, family_name, given_name, name, openid, profile, sub",
                  "minItems": 1,
                  "uniqueItems": true,
                  "items": {
                    "type": "string"
                  }
                }
              },
              "required": [
                "id",
                "issuedAt",
                "expireAt",
                "organizationId",
                "serviceId",
                "identityId",
                "scope"
              ]
            }
          },
          "400": {
            "$ref": "#/paths/~1admin~1clients/post/responses/400"
          },
          "401": {
            "$ref": "#/paths/~1admin~1grants/get/responses/401"
          },
          "404": {
            "$ref": "#/paths/~1admin~1clients~1%7BclientId%7D/get/responses/404"
          },
          "500": {
            "$ref": "#/paths/~1admin~1grants/get/responses/500"
          }
        }
      },
      "delete": {
        "operationId": "deleteGrant",
        "summary": "Delete a grant",
        "security": [
          {
            "SubscriptionKey": []
          }
        ],
        "responses": {
          "204": {
            "description": "Operation is completed"
          },
          "400": {
            "$ref": "#/paths/~1admin~1clients/post/responses/400"
          },
          "401": {
            "$ref": "#/paths/~1admin~1grants/get/responses/401"
          },
          "404": {
            "$ref": "#/paths/~1admin~1clients~1%7BclientId%7D/get/responses/404"
          },
          "500": {
            "$ref": "#/paths/~1admin~1grants/get/responses/500"
          }
        }
      }
    }
  },
  "securityDefinitions": {
    "SubscriptionKey": {
      "type": "apiKey",
      "name": "Ocp-Apim-Subscription-Key",
      "in": "header",
      "description": "The API key obtained through the developer portal or the getService operation."
    }
  }
}
