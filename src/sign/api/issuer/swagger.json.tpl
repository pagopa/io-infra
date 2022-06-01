{
  "swagger": "2.0",
  "info": {
    "version": "3.3.0",
    "title": "IO Sign API for Issuer",
    "contact": {
      "name": "PagoPA",
      "url": "https://pagopa.it"
    },
  },
  "host": "{{host}}",
  "basePath": "/sign/v1",
  "schemes": [
    "https"
  ],
  "security": [
    {
      "SubscriptionKey": []
    }
  ],
  "paths": {
    "/info": {},
    "/signature-requests": {
      "post": {
        "operationId": "RequestSignature",
        "parameters": [
          {
            "name": "Signature Request",
            "in": "body",
            "schema": {
              "$ref": "#/definitions/NewSignatureRequest"
            },
          }
        ],
        "responses": {
          "201": {
            "description": "Signature Request created",
            "schema": {
              "$ref": "#/definitions/CreatedSignatureRequest"
            },
            "examples": {
              "application/json": {
                "id": "ae4b4578-571b-41f3-8509-d16afece5e5c"
              }
            }
          },
          "400": {
            "description": "Invalid payload.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            },
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
            "description": "Internal server error",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    }
  },
  "definitions": {
     "FiscalCode": {
      "type": "string",
      "description": "User's fiscal code.",
      "format": "FiscalCode",
      "x-import": "@pagopa/ts-commons/lib/strings",
      "example": "SPNDNL80R13C555X"
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
    "Clause": {
      "type": "object",
      "required": ["title, required"],
      "properties": {
        "title": {
          "type": "string"
        },
        "required": {
          "type": "boolean"
        }
      },
    },
    "Document": {
      "type": "object",
      "properties": {
        "id": {
          "type": "string",
        },
        "title": {
          "type": "string"
        },
        "clauses": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Clause"
          }
        }
      }
    },
    "NewSignatureRequest": {
      "type": "object",
      "properties": {
        "fiscalCode": {
          "$ref": "#/definitions/FiscalCode",
        },
        "documents": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Document",
          }
        }
      }
    },
    "CreatedSignatureRequest": {
      "type": "object",
      "properties": {
        "id": {
          "type": "string",
          "description": "The identifier of the created signature request"
        }
      }
    }
  },
  "responses": {},
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