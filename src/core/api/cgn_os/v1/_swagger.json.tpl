{
  "swagger": "2.0",
  "info": {
    "version": "1.0.0",
    "title": "IO Functions CGN operator search",
    "contact": {
      "name": "IO team",
      "url": "https://forum.italia.it/c/progetto-io"
    },
    "x-logo": {
      "url": "https://io.italia.it/assets/img/io-logo-blue.svg"
    },
    "description": "Documentation of the IO operator search API here.\n"
  },
  "host": "${host}",
  "basePath": "/api/v1/cgn/operator-search",
  "schemes": [
    "https"
  ],
  "security": [
    {
      "SubscriptionKey": []
    }
  ],
  "paths": {
    "/published-product-categories": {
      "get": {
        "operationId": "getPublishedProductCategories",
        "summary": "List of published product categories",
        "description": "List of categories that have at least a published discount\n",
        "responses": {
          "200": {
            "description": "List of categories that have at least a published discount",
            "schema": {
              "$ref": "#/definitions/PublishedProductCategories"
            }
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
    "/online-merchants": {
      "post": {
        "operationId": "getOnlineMerchants",
        "summary": "List of online merchants",
        "description": "List of online merchants alphabetically ordered\n",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": false,
            "schema": {
              "$ref": "#/definitions/OnlineMerchantSearchRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "List of online merchants for the given query parameters",
            "schema": {
              "$ref": "#/definitions/OnlineMerchants"
            }
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
    "/offline-merchants": {
      "post": {
        "operationId": "getOfflineMerchants",
        "summary": "List of merchants with a physical address",
        "description": "List of merchants with physical address, ordered by distance from the user by default\n",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/OfflineMerchantSearchRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "List of physical merchants for the given query parameters",
            "schema": {
              "$ref": "#/definitions/OfflineMerchants"
            }
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
    "/merchants/{merchantId}": {
      "parameters": [
        {
          "name": "merchantId",
          "in": "path",
          "type": "string",
          "minLength": 1,
          "required": true,
          "description": "Merchant Identifier"
        }
      ],
      "get": {
        "operationId": "getMerchant",
        "summary": "Retrieve merchant details",
        "description": "Retrieve merchant details together with published discounts\n",
        "responses": {
          "200": {
            "description": "Found",
            "schema": {
              "$ref": "#/definitions/Merchant"
            }
          },
          "404": {
            "$ref": "#/responses/NotFound"
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
  "securityDefinitions": {
    "SubscriptionKey": {
      "type": "apiKey",
      "name": "Ocp-Apim-Subscription-Key",
      "in": "header",
      "description": "The API key to access this function app."
    }
  },
  "definitions": {
    "ProblemJson": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v17.3.0/openapi/definitions.yaml#/ProblemJson"
    },
    "Merchant": {
      "type": "object",
      "required": [
        "id",
        "name",
        "discounts"
      ],
      "properties": {
        "id": {
          "type": "string",
          "minLength": 1
        },
        "name": {
          "type": "string",
          "minLength": 1
        },
        "description": {
          "type": "string",
          "minLength": 1
        },
        "websiteUrl": {
          "type": "string",
          "minLength": 1
        },
        "discountCodeType": {
          "$ref": "#/definitions/DiscountCodeType"
        },
        "imageUrl": {
          "type": "string",
          "minLength": 1
        },
        "discounts": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Discount"
          }
        },
        "addresses": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Address"
          }
        }
      }
    },
    "Discount": {
      "type": "object",
      "required": [
        "id",
        "name",
        "startDate",
        "endDate",
        "productCategories"
      ],
      "properties": {
        "id": {
          "type": "string",
          "minLength": 1
        },
        "name": {
          "type": "string",
          "minLength": 1
        },
        "description": {
          "type": "string",
          "minLength": 1
        },
        "startDate": {
          "type": "string",
          "format": "date"
        },
        "endDate": {
          "type": "string",
          "format": "date"
        },
        "productCategories": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/ProductCategory"
          }
        },
        "discount": {
          "type": "number",
          "format": "double",
          "minimum": 1
        },
        "condition": {
          "type": "string",
          "minLength": 1
        },
        "staticCode": {
          "type": "string",
          "minLength": 1
        },
        "landingPageUrl": {
          "type": "string",
          "minLength": 1
        },
        "landingPageReferrer": {
          "type": "string",
          "minLength": 1
        },
        "discountUrl": {
          "type": "string",
          "minLength": 1,
          "maxLength": 500
        }
      }
    },
    "PublishedProductCategories": {
      "type": "object",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/ProductCategory"
          }
        }
      }
    },
    "OnlineMerchants": {
      "type": "object",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/OnlineMerchant"
          }
        }
      }
    },
    "OnlineMerchant": {
      "type": "object",
      "required": [
        "id",
        "name",
        "productCategories",
        "websiteUrl",
        "discountCodeType"
      ],
      "properties": {
        "id": {
          "type": "string",
          "minLength": 1
        },
        "name": {
          "type": "string",
          "minLength": 1
        },
        "productCategories": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/ProductCategory"
          }
        },
        "websiteUrl": {
          "type": "string",
          "minLength": 1
        },
        "discountCodeType": {
          "$ref": "#/definitions/DiscountCodeType"
        }
      }
    },
    "OfflineMerchants": {
      "type": "object",
      "required": [
        "items"
      ],
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/OfflineMerchant"
          }
        }
      }
    },
    "OfflineMerchant": {
      "type": "object",
      "required": [
        "id",
        "name",
        "productCategories",
        "address"
      ],
      "properties": {
        "id": {
          "type": "string",
          "minLength": 1
        },
        "name": {
          "type": "string",
          "minLength": 1
        },
        "productCategories": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/ProductCategory"
          }
        },
        "address": {
          "$ref": "#/definitions/Address"
        },
        "distance": {
          "description": "Distance in meters",
          "type": "integer",
          "minimum": 0
        }
      }
    },
    "Address": {
      "type": "object",
      "required": [
        "full_address"
      ],
      "properties": {
        "full_address": {
          "type": "string",
          "minLength": 1
        },
        "latitude": {
          "type": "number"
        },
        "longitude": {
          "type": "number"
        }
      }
    },
    "ProductCategory": {
      "type": "string",
      "enum": [
        "bankingServices",
        "cultureAndEntertainment",
        "health",
        "home",
        "jobOffers",
        "learning",
        "sports",
        "sustainableMobility",
        "telephonyAndInternet",
        "travelling"
      ]
    },
    "DiscountCodeType": {
      "type": "string",
      "enum": [
        "static",
        "api",
        "landingpage",
        "bucket"
      ]
    },
    "OnlineMerchantSearchRequest": {
      "type": "object",
      "properties": {
        "merchantName": {
          "type": "string",
          "description": "Text used for searching merchants by their name",
          "minLength": 1
        },
        "productCategories": {
          "type": "array",
          "description": "List of product categories to filter the results",
          "items": {
            "$ref": "#/definitions/ProductCategory"
          }
        },
        "page": {
          "type": "integer",
          "description": "page of result",
          "default": 0,
          "minimum": 0
        },
        "pageSize": {
          "type": "integer",
          "description": "elements per page",
          "default": 100,
          "minimum": 1
        }
      }
    },
    "OfflineMerchantSearchRequest": {
      "type": "object",
      "properties": {
        "merchantName": {
          "type": "string",
          "description": "Text used for searching merchants by their name",
          "minLength": 1
        },
        "productCategories": {
          "type": "array",
          "description": "List of product categories to filter the results",
          "items": {
            "$ref": "#/definitions/ProductCategory"
          }
        },
        "page": {
          "type": "integer",
          "description": "page of result",
          "default": 0,
          "minimum": 0
        },
        "pageSize": {
          "type": "integer",
          "description": "elements per page",
          "default": 100,
          "minimum": 1
        },
        "userCoordinates": {
          "$ref": "#/definitions/Coordinates",
          "description": "User coordinates"
        },
        "boundingBox": {
          "$ref": "#/definitions/BoundingBox",
          "description": "search area bounding box"
        },
        "ordering": {
          "type": "string",
          "enum": [
            "distance",
            "alphabetic"
          ],
          "default": "distance",
          "description": "Ordering type, by distance or alphabetical"
        }
      }
    },
    "BoundingBox": {
      "type": "object",
      "required": [
        "coordinates",
        "deltaLatitude",
        "deltaLongitude"
      ],
      "properties": {
        "coordinates": {
          "$ref": "#/definitions/Coordinates"
        },
        "deltaLatitude": {
          "type": "number",
          "description": "Bounding box delta latitude"
        },
        "deltaLongitude": {
          "type": "number",
          "description": "Bounding box delta longitude"
        }
      }
    },
    "Coordinates": {
      "type": "object",
      "required": [
        "latitude",
        "longitude"
      ],
      "properties": {
        "latitude": {
          "type": "number"
        },
        "longitude": {
          "type": "number"
        }
      }
    }
  },
  "responses": {
    "InvalidRequest": {
      "description": "Bad request"
    },
    "Forbidden": {
      "description": "Forbidden"
    },
    "NotFound": {
      "description": "Not found"
    }
  }
}