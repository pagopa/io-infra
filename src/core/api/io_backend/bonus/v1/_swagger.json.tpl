{
  "swagger": "2.0",
  "info": {
    "version": "1.0.0",
    "title": "Bonus vacanze API"
  },
  "host": "${host}",
  "basePath": "/api/v1",
  "schemes": [
    "https"
  ],
  "security": [
    {
      "Bearer": []
    }
  ],
  "paths": {
    "/bonus/vacanze/eligibility": {
      "post": {
        "operationId": "startBonusEligibilityCheck",
        "summary": "Start bonus eligibility check (ISEE)",
        "responses": {
          "401": {
            "description": "Bearer token null or expired."
          },
          "404": {
            "description": "The feature has been dismissed",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      },
      "get": {
        "operationId": "getBonusEligibilityCheck",
        "summary": "Get eligibility (ISEE) check information for user's bonus",
        "responses": {
          "200": {
            "description": "Eligibility (ISEE) check information for user's bonus",
            "schema": {
              "$ref": "#/definitions/EligibilityCheck"
            }
          },
          "202": {
            "description": "Processing request."
          },
          "401": {
            "description": "Bearer token null or expired."
          },
          "404": {
            "description": "Request not found."
          },
          "410": {
            "description": "Request expired"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/bonus/vacanze/activations": {
      "post": {
        "operationId": "startBonusActivationProcedure",
        "summary": "Start bonus activation request procedure",
        "responses": {
          "401": {
            "description": "Bearer token null or expired."
          },
          "404": {
            "description": "The feature has been dismissed"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      },
      "get": {
        "operationId": "getAllBonusActivations",
        "summary": "Get all IDs of the bonus activations requested by\nthe authenticated user or by any between his family member\n",
        "responses": {
          "200": {
            "description": "List of bonus activations ID belonging to the authenticated user\nor to any member of her family (former and actual)\n",
            "schema": {
              "$ref": "#/definitions/PaginatedBonusActivationsCollection"
            }
          },
          "401": {
            "description": "Bearer token null or expired."
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/bonus/vacanze/activations/{bonus_id}": {
      "get": {
        "operationId": "getLatestBonusActivationById",
        "summary": "Get the activation details for the latest version\nof the bonus entity identified by the provided id\n",
        "parameters": [
          {
            "name": "bonus_id",
            "in": "path",
            "required": true,
            "description": "Bonus activation ID.",
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "Bonus activation details.",
            "schema": {
              "$ref": "#/definitions/BonusActivationWithQrCode"
            }
          },
          "202": {
            "description": "Processing request.",
            "schema": {
              "$ref": "#/definitions/InstanceId"
            }
          },
          "401": {
            "description": "Bearer token null or expired."
          },
          "404": {
            "description": "No bonus found."
          },
          "500": {
            "description": "Service unavailable.",
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
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v10.2.3/openapi/definitions.yaml#/FiscalCode"
    },
    "InstanceId": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/InstanceId"
    },
    "ProblemJson": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v10.2.3/openapi/definitions.yaml#/ProblemJson"
    },
    "FamilyMember": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/FamilyMember"
    },
    "FamilyMembers": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/FamilyMembers"
    },
    "Dsu": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/Dsu"
    },
    "EligibilityCheckSuccess": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/EligibilityCheckSuccess"
    },
    "EligibilityCheckSuccessEligible": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/EligibilityCheckSuccessEligible"
    },
    "EligibilityCheckSuccessIneligible": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/EligibilityCheckSuccessIneligible"
    },
    "EligibilityCheckSuccessConflict": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/EligibilityCheckSuccessConflict"
    },
    "EligibilityCheckFailure": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/EligibilityCheckFailure"
    },
    "EligibilityCheck": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/EligibilityCheck"
    },
    "BonusActivationStatus": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/BonusActivationStatus"
    },
    "BonusCode": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/BonusCode"
    },
    "BonusActivation": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/BonusActivation"
    },
    "Timestamp": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v10.2.3/openapi/definitions.yaml#/Timestamp"
    },
    "BonusActivationItem": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/BonusActivationItem"
    },
    "BonusActivationCollection": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/BonusActivationCollection"
    },
    "PaginationResponse": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v10.2.3/openapi/definitions.yaml#/PaginationResponse"
    },
    "PaginatedBonusActivationsCollection": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-bonus/master/openapi/index.yaml#/definitions/PaginatedBonusActivationsCollection"
    },
    "QrCodeImage": {
      "type": "object",
      "properties": {
        "content": {
          "type": "string"
        },
        "mime_type": {
          "type": "string"
        }
      },
      "required": [
        "content",
        "mime_type"
      ]
    },
    "QrCode": {
      "type": "object",
      "properties": {
        "qr_code": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/QrCodeImage"
          }
        }
      },
      "required": [
        "qr_code"
      ]
    },
    "BonusActivationWithQrCode": {
      "allOf": [
        {
          "$ref": "#/definitions/BonusActivation"
        },
        {
          "$ref": "#/definitions/QrCode"
        }
      ]
    }
  },
  "securityDefinitions": {
    "Bearer": {
      "type": "apiKey",
      "name": "Authorization",
      "in": "header"
    }
  }
}