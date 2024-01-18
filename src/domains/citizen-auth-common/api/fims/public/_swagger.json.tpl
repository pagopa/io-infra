{
  "swagger": "2.0",
  "info": {
    "title": "OpenID Provider",
    "description": "OpenID Provider service",
    "version": "1.0.7"
  },
  "host": "api.openid-provider.io.italia.it",
  "schemes": [
    "https"
  ],
  "paths": {
    "/oauth/authorize": {
      "get": {
        "operationId": "authorize",
        "summary": "Initialize an OAuth 2.0 flow",
        "description": "Initializes an OAuth 2.0 flow using a response_type. See RFC 6749 (https://tools.ietf.org/html/rfc6749) for more details.",
        "parameters": [
          {
            "$ref": "#/parameters/queryResponseType"
          },
          {
            "$ref": "#/parameters/queryClientId"
          },
          {
            "$ref": "#/parameters/queryResponseMode"
          },
          {
            "$ref": "#/parameters/queryRedirectUri"
          },
          {
            "$ref": "#/parameters/queryScope"
          },
          {
            "$ref": "#/parameters/queryState"
          },
          {
            "$ref": "#/parameters/queryNonce"
          }
        ],
        "responses": {
          "200": {
            "$ref": "#/responses/200AuthenticationResponse"
          },
          "302": {
            "$ref": "#/responses/302AuthenticationResponse"
          },
          "400": {
            "$ref": "#/responses/400HtmlBadRequest"
          }
        }
      }
    },
    "/.well-known/openid-configuration": {
      "get": {
        "operationId": "openidConfiguration",
        "summary": "OpenID Connect Discovery endpoint",
        "description": "This endpoint follows the specification defined at http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata. It provides a mechanism for an OpenID Connect Relying Party to discover the End-User's OpenID Provider and obtain information needed to interact with it, including its OAuth 2.0 endpoint locations.",
        "responses": {
          "200": {
            "$ref": "#/responses/200OpenIDDiscoveryResponse"
          },
          "500": {
            "$ref": "#/responses/500InternalServerError"
          }
        }
      }
    },
    "/info": {
      "get": {
        "operationId": "getInfo",
        "summary": "Get info of the service",
        "description": "Return the information of the service, this endpoint\ncan be used as health check.\n",
        "responses": {
          "200": {
            "description": "Return the information of the service",
            "schema": {
              "$ref": "#/definitions/GetInfo"
            }
          },
          "500": {
            "description": "An error occurred",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    }
  },
  "parameters": {
    "headerIdentityId": {
      "name": "identityId",
      "in": "header",
      "required": true,
      "description": "The identifier of the user",
      "type": "string"
    },
    "pathClientId": {
      "name": "clientId",
      "in": "path",
      "required": true,
      "description": "The identifier of a client",
      "type": "string"
    },
    "pathOrganizationId": {
      "name": "organizationId",
      "description": "The organization identifier",
      "in": "path",
      "required": true,
      "type": "string"
    },
    "pathServiceId": {
      "name": "serviceId",
      "description": "The service identifier",
      "in": "path",
      "required": true,
      "type": "string"
    },
    "queryOrganizationId": {
      "name": "organizationId",
      "description": "The client organization",
      "in": "query",
      "required": false,
      "type": "string"
    },
    "queryServiceId": {
      "name": "serviceId",
      "description": "The client service",
      "in": "query",
      "required": false,
      "type": "string"
    },
    "queryResponseType": {
      "name": "response_type",
      "in": "query",
      "required": true,
      "description": "MUST be one of the listed available values. Any response_type other than 'code' or 'token' is only supported in conjunction with scope=openid. As per the OAuth specification: 'code' is used for authorization code grant type flow, 'token' is used for implicit grant type flow, 'token id_token' is an extension provided by OpenID Connect, and 'code id_token', 'id_token', and 'none' are extensions provided by OpenID Connect Multiple Response Types. At the moment the only available value is id_token.",
      "type": "string",
      "enum": [
        "id_token"
      ]
    },
    "queryClientId": {
      "name": "client_id",
      "in": "query",
      "required": true,
      "description": "This is the 'client_id' of the requesting client. Maximum 255 characters.",
      "type": "string"
    },
    "queryRedirectUri": {
      "name": "redirect_uri",
      "in": "query",
      "required": false,
      "description": "The 'redirect_uri' that was registered for this client. It is required if multiple redirect_uri's have been registered for this client. If the scope contains openid, this field becomes MANDATORY.",
      "type": "string"
    },
    "queryScope": {
      "name": "scope",
      "in": "query",
      "required": false,
      "description": "Only SCOPE values that were registered for this client will be granted. If only non-matching SCOPE values are requested, the request will fail.",
      "type": "string"
    },
    "queryNonce": {
      "name": "nonce",
      "in": "query",
      "required": false,
      "description": "This is required for response_type 'token id_token'. Typically, in an OpenID authorization scheme, the nonce represents a cryptographically strong random string that is used to prevent intercepted responses from being reused.",
      "type": "string"
    },
    "queryState": {
      "name": "state",
      "in": "query",
      "required": false,
      "description": "Value opaque to the server, used by the client to track its session. It will be returned as received.",
      "type": "string"
    },
    "queryResponseMode": {
      "name": "response_mode",
      "in": "query",
      "required": false,
      "description": "Specify the method of returning the authorization response. As per the OpenID specification, use of this parameter is NOT RECOMMENDED if you are using the same response mode as the default response mode for the given response type. It MUST be one of the listed values in order to be accepted: 'fragment', 'form_post'.\nfragment\n  In this mode, Authorization Response parameters are encoded in the fragment added to the redirect_uri when redirecting back to the Client.\nform_post\n  In this mode, Authorization Response parameters are encoded as HTML form values that are auto-submitted in the User Agent, and thus are transmitted via the HTTP POST method to the Client, with the result parameters being encoded in the body using the application/x-www-form-urlencoded format.",
      "type": "string",
      "enum": [
        "fragment",
        "form_post"
      ]
    },
    "bodyClientDefinition": {
      "in": "body",
      "name": "payload",
      "schema": {
        "$ref": "#/definitions/APIClientDefinition"
      }
    }
  },
  "definitions": {
    "APIScope": {
      "type": "string",
      "enum": [
        "acr",
        "auth_time",
        "date_of_birth",
        "email_verified",
        "family_name",
        "given_name",
        "name",
        "openid",
        "profile",
        "sub"
      ]
    },
    "APIGrantDetail": {
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
          "$ref": "#/definitions/OrganizationFiscalCode"
        },
        "serviceId": {
          "$ref": "#/definitions/ServiceId"
        },
        "identityId": {
          "$ref": "#/definitions/FiscalCode"
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
    },
    "APIGrantList": {
      "description": "List of grant",
      "type": "object",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/APIGrantDetail"
          }
        }
      },
      "required": [
        "items"
      ]
    },
    "APIClientDefinition": {
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
          "$ref": "#/definitions/OrganizationFiscalCode"
        },
        "service_id": {
          "$ref": "#/definitions/ServiceId"
        }
      }
    },
    "APIClientDetail": {
      "allOf": [
        {
          "$ref": "#/definitions/APIClientDefinition"
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
    },
    "APIClientList": {
      "description": "List of provider clients",
      "type": "object",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/APIClientDetail"
          }
        }
      },
      "required": [
        "items"
      ]
    },
    "GetInfo": {
      "type": "object",
      "properties": {
        "name": {
          "type": "string",
          "minLength": 1,
          "description": "The name of the service",
          "example": "name"
        },
        "version": {
          "type": "string",
          "minLength": 1,
          "description": "The version of the service",
          "example": "1.0.0"
        }
      },
      "required": [
        "name",
        "version"
      ]
    },
    "OpenIDDiscovery": {
      "description": "The OpenID configuration document as defined by the specification: http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata",
      "required": [
        "authorization_endpoint",
        "id_token_signing_alg_values_supported",
        "issuer",
        "jwks_uri",
        "response_types_supported",
        "subject_types_supported",
        "token_endpoint"
      ],
      "type": "object",
      "properties": {
        "userinfo_endpoint": {
          "type": "string",
          "example": "https://example.com:8443/openid/connect/v1/userinfo",
          "description": "URL of the user info endpoint"
        },
        "jwks_uri": {
          "type": "string",
          "example": "https://example.com/openid/connect/jwks.json",
          "description": "URL of JSON Web Key Set document"
        },
        "scopes_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "openid"
          ],
          "description": "list of the OAuth 2.0 scope values that this server supports"
        },
        "subject_types_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "pairwise"
          ],
          "description": "list of the Subject Identifier types that this OP supports"
        },
        "token_endpoint": {
          "type": "string",
          "example": "https://example.com:8443/auth/oauth/v2/token",
          "description": "URL of the OAuth 2.0 token endpoint"
        },
        "id_token_signing_alg_values_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "RS256",
            "HS256"
          ],
          "description": "list of the JWS signing algorithms (alg values) supported by the OP for the ID Token to encode the Claims in a JWT"
        },
        "response_types_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "code",
            "token_id_token"
          ],
          "description": "ist of the OAuth 2.0 response_type values that this OP supports"
        },
        "claims_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "sub",
            "iss",
            "auth_time",
            "acr"
          ],
          "description": "list of the Claim Names of the Claims that the OpenID Provider MAY be able to supply values for"
        },
        "authorization_endpoint": {
          "type": "string",
          "example": "https://example.com:8443/auth/oauth/v2/authorize",
          "description": "URL of the OAuth 2.0 authorization endpoint"
        },
        "issuer": {
          "type": "string",
          "example": "https://example.com",
          "description": "the identifier of the token's issuer. This is identical to the 'iss' Claim value in ID Tokens"
        },
        "grant_types_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "authorization_code",
            "implicit"
          ],
          "description": "list of the OAuth 2.0 Grant Type values that this OP supports"
        },
        "acr_values_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "urn:mace:incommon:iap:silver"
          ],
          "description": "list of the Authentication Context Class References that this OP supports"
        },
        "token_endpoint_auth_methods_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "client_secret_basic"
          ],
          "description": "list of Client Authentication methods supported by this Token Endpoint"
        },
        "token_endpoint_auth_signing_alg_values_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "RS256"
          ],
          "description": "list of the JWS signing algorithms (alg values) supported by the Token Endpoint for the signature on the JWT used to authenticate the Client at the Token Endpoint for the private_key_jwt and client_secret_jwt authentication methods. Servers SHOULD support RS256. The value none MUST NOT be used."
        },
        "display_values_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "page",
            "popup"
          ],
          "description": "list of the display parameter values that the OpenID Provider supports"
        },
        "claim_types_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "normal"
          ],
          "description": "list of the Claim Types that the OpenID Provider supports"
        },
        "service_documentation": {
          "type": "string",
          "example": "http://masdemo12.dev.ca.com:8443/openid/connect/v1/service_documentation.html",
          "description": "URL of a page containing human-readable information that developers might want or need to know when using the OpenID Provider"
        },
        "ui_locales_supported": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "example": [
            "en-US",
            "en-GB"
          ],
          "description": "Languages and scripts supported for the user interface"
        }
      }
    },
    "OAuthError": {
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
    "OrganizationFiscalCode": {
      "type": "string",
      "description": "Organization fiscal code.",
      "format": "OrganizationFiscalCode",
      "x-import": "@pagopa/ts-commons/lib/strings",
      "example": "12345678901"
    },
    "ServiceId": {
      "type": "string",
      "description": "The ID of the Service. Equals the subscriptionId of a registered\nAPI user.",
      "minLength": 1
    },
    "FiscalCode": {
      "type": "string",
      "description": "User's fiscal code.",
      "format": "FiscalCode",
      "x-import": "@pagopa/ts-commons/lib/strings",
      "example": "SPNDNL80R13C555X"
    }
  },
  "securityDefinitions": {
    "SubscriptionKey": {
      "type": "apiKey",
      "name": "Ocp-Apim-Subscription-Key",
      "in": "header",
      "description": "The API key obtained through the developer portal or the getService operation."
    }
  },
  "responses": {
    "200GrantListResponse": {
      "description": "List of grant",
      "schema": {
        "$ref": "#/definitions/APIGrantList"
      }
    },
    "200GrantDetailResponse": {
      "description": "Detail of a grant",
      "schema": {
        "$ref": "#/definitions/APIGrantDetail"
      }
    },
    "200ClientResponse": {
      "description": "Detail of a client",
      "schema": {
        "$ref": "#/definitions/APIClientDetail"
      }
    },
    "200ClientListResponse": {
      "description": "List of clients",
      "schema": {
        "$ref": "#/definitions/APIClientList"
      }
    },
    "200AuthenticationResponse": {
      "description": "This response is returned if the chosen response_mode was form_post. In this case the authorization Response parameters are encoded as HTML form values that are auto-submitted in the User Agent, and thus are transmitted via the HTTP POST method to the Client, with the result parameters being encoded in the body using the application/x-www-form-urlencoded format.",
      "headers": {
        "Pragma": {
          "description": "Pragma directive",
          "type": "string",
          "default": "no-cache"
        },
        "Cache-Control": {
          "description": "Cache control directive",
          "type": "string",
          "default": "no-store"
        },
        "Content-Type": {
          "description": "Cache control directive",
          "type": "string",
          "default": "text/html;charset=UTF-8"
        }
      },
      "schema": {
        "type": "string"
      }
    },
    "302AuthenticationResponse": {
      "description": "Will contain either: A success response including the redirect location header to the server that handles the authentication.  The redirect parameter 'sessionData's structure looks like the model schema shown OR 'invalid mag-identifier' OR 'invalid scope' OR 'unsupported response type' OR 'unauthorized client'. The non-successful conditions may include redirect query params as follows: 'error', string with default value:  invalid_request 'error_description', string with description of error 'state', string with no default value.  It is opaque to the server and returned as received. 'x-ca-err', string with default 3000108",
      "headers": {
        "location": {
          "description": "These parameters are returned from the Authorization Endpoint:\n  access_token\n      OAuth 2.0 Access Token. This is returned unless the response_type value used is id_token.\n  token_type\n      OAuth 2.0 Token Type value. The value MUST be Bearer or another token_type value that the Client has negotiated with the Authorization Server. Clients implementing this profile MUST support the OAuth 2.0 Bearer Token Usage [RFC6750] specification. This profile only describes the use of bearer tokens. This is returned in the same cases as access_token is.\n  id_token\n      REQUIRED. ID Token.\n  state\n      OAuth 2.0 state value. REQUIRED if the state parameter is present in the Authorization Request. Clients MUST verify that the state value is equal to the value of state parameter in the Authorization Request.\n  expires_in\n      OPTIONAL. Expiration time of the Access Token in seconds since the response was generated.",
          "type": "string"
        },
        "Pragma": {
          "description": "Pragma directive",
          "type": "string",
          "default": "no-cache"
        },
        "Cache-Control": {
          "description": "Cache control directive",
          "type": "string",
          "default": "no-store"
        }
      }
    },
    "200OpenIDDiscoveryResponse": {
      "description": "OpenID Discovery Configuration",
      "schema": {
        "$ref": "#/definitions/OpenIDDiscovery"
      }
    },
    "204NoContent": {
      "description": "Operation is completed"
    },
    "400HtmlBadRequest": {
      "description": "This response is returned if an error occurred but we can't redirect to a given client callback.",
      "headers": {
        "Pragma": {
          "description": "Pragma directive",
          "type": "string",
          "default": "no-cache"
        },
        "Cache-Control": {
          "description": "Cache control directive",
          "type": "string",
          "default": "no-store"
        },
        "Content-Type": {
          "description": "Cache control directive",
          "type": "string",
          "default": "text/html;charset=UTF-8"
        }
      },
      "schema": {
        "type": "string"
      }
    },
    "400BadRequest": {
      "description": "The given payload is invalid",
      "schema": {
        "$ref": "#/definitions/OAuthError"
      }
    },
    "401Unauthorized": {
      "description": "The authorization token is missing or invalid",
      "schema": {
        "type": "string"
      }
    },
    "404NotFound": {
      "description": "The requested entity is not found",
      "schema": {
        "$ref": "#/definitions/ProblemJson"
      }
    },
    "500InternalServerError": {
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
        "$ref": "#/definitions/ProblemJson"
      }
    }
  }
}
