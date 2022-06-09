{
  "openapi": "3.0.3",
  "info": {
    "title": "IO Sign - Issuer API",
    "version": "0.1.0"
  },
  "servers": [
    {
      "url": "https://api.io.pagopa.it/api/v1/sign",
      "description": "Production"
    }
  ],
  "security": [
    {
      "SubscriptionKey": []
    }
  ],
  "paths": {
    "/products": {
      "post": {
        "operationId": "createProduct",
        "summary": "Create a Product",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreateProductBody"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Product created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProductDetailView"
                }
              }
            }
          },
          "400": {
            "$ref": "#/components/responses/BadRequest"
          },
          "403": {
            "$ref": "#/components/responses/Forbidden"
          },
          "default": {
            "$ref": "#/components/responses/Unexpected"
          }
        }
      }
    },
    "/products/{productId}": {
      "get": {
        "operationId": "getProductById",
        "summary": "Get a Product by Id",
        "parameters": [
          {
            "in": "path",
            "name": "productId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "The product detail",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProductDetailView"
                }
              }
            }
          },
          "403": {
            "$ref": "#/components/responses/Forbidden"
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          },
          "default": {
            "$ref": "#/components/responses/Unexpected"
          }
        }
      }
    },
    "/signature-requests": {
      "post": {
        "operationId": "requestSignature",
        "summary": "Request a Signature (creating a Signature Request)",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RequestSignatureBody"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "RequestSignature created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SignatureRequestDetailView"
                }
              }
            }
          },
          "400": {
            "$ref": "#/components/responses/BadRequest"
          },
          "403": {
            "$ref": "#/components/responses/Forbidden"
          },
          "404": {
            "description": "Product not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "default": {
            "$ref": "#/components/responses/Unexpected"
          }
        }
      }
    },
    "/signature-requests/{productId}": {
      "get": {
        "operationId": "getSignatureRequestById",
        "summary": "Get a Signature Request By Id",
        "parameters": [
          {
            "in": "path",
            "name": "productId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "The Signature Request detail",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SignatureRequestDetailView"
                }
              }
            }
          },
          "403": {
            "$ref": "#/components/responses/Forbidden"
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          },
          "default": {
            "$ref": "#/components/responses/Unexpected"
          }
        }
      }
    }
  },
  "components": {
    "securitySchemes": {
      "SubscriptionKey": {
        "type": "apiKey",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header",
        "description": "The API key obtained through the developer portal"
      }
    },
    "responses": {
      "NotFound": {
        "description": "The specified resource was not found",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ProblemJson"
            }
          }
        }
      },
      "BadRequest": {
        "description": "Validation error on body",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ProblemJson"
            }
          }
        }
      },
      "Forbidden": {
        "description": "You don't have enough privileges to perform this action",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ProblemJson"
            }
          }
        }
      },
      "Unexpected": {
        "description": "Unexpected error",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ProblemJson"
            }
          }
        }
      }
    },
    "schemas": {
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
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
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
            "description": "An absolute URI that identifies the specific occurrence of the problem. It may or may not yield further information if dereferenced."
          }
        },
        "required": [
          "title",
          "status",
          "detail"
        ]
      },
      "FiscalCode": {
        "type": "string",
        "description": "User's fiscal code.",
        "format": "FiscalCode",
        "x-import": "@pagopa/ts-commons/lib/strings",
        "example": "SPNDNL80R13C555X"
      },
      "Clause": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string"
          },
          "required": {
            "type": "boolean"
          }
        },
        "required": [
          "title",
          "required"
        ]
      },
      "DocumentMetadata": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string"
          },
          "clauses": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Clause"
            },
            "minItems": 1,
            "uniqueItems": true
          }
        },
        "required": [
          "title",
          "clauses"
        ]
      },
      "Document": {
        "allOf": [
          {
            "type": "object",
            "properties": {
              "id": {
                "type": "string",
                "format": "uuid"
              }
            },
            "required": [
              "id"
            ]
          },
          {
            "$ref": "#/components/schemas/DocumentMetadata"
          }
        ]
      },
      "ProductId": {
        "type": "string",
        "format": "uuid"
      },
      "CreateProductBody": {
        "type": "object",
        "properties": {
          "documents": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/DocumentMetadata"
            },
            "minItems": 1,
            "uniqueItems": true
          }
        },
        "required": [
          "documents"
        ]
      },
      "ProductDetailView": {
        "type": "object",
        "properties": {
          "id": {
            "$ref": "#/components/schemas/ProductId"
          },
          "documents": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/DocumentMetadata"
            }
          }
        },
        "required": [
          "id",
          "documents"
        ]
      },
      "RequestSignatureBody": {
        "type": "object",
        "properties": {
          "productId": {
            "$ref": "#/components/schemas/ProductId"
          },
          "fiscalCode": {
            "$ref": "#/components/schemas/FiscalCode"
          }
        },
        "required": [
          "productId",
          "fiscalCode"
        ]
      },
      "SignatureRequestDetailView": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid"
          },
          "productId": {
            "type": "string",
            "format": "uuid"
          },
          "documents": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Document"
            }
          }
        },
        "required": [
          "id",
          "productId",
          "documents"
        ]
      }
    }
  }
}