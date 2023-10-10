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
    "fims/oauth/authorize": {
      "get": {
        "operationId": "authorize",
        "summary": "Initialize an OAuth 2.0 flow",
        "description": "Initializes an OAuth 2.0 flow using a response_type. See RFC 6749 (https://tools.ietf.org/html/rfc6749) for more details.",
        "parameters": [
          {
            "name": "response_type",
            "in": "query",
            "required": true,
            "description": "MUST be one of the listed available values. Any response_type other than 'code' or 'token' is only supported in conjunction with scope=openid. As per the OAuth specification: 'code' is used for authorization code grant type flow, 'token' is used for implicit grant type flow, 'token id_token' is an extension provided by OpenID Connect, and 'code id_token', 'id_token', and 'none' are extensions provided by OpenID Connect Multiple Response Types. At the moment the only available value is id_token.",
            "type": "string",
            "enum": [
              "id_token"
            ]
          },
          {
            "name": "client_id",
            "in": "query",
            "required": true,
            "description": "This is the 'client_id' of the requesting client. Maximum 255 characters.",
            "type": "string"
          },
          {
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
          {
            "name": "redirect_uri",
            "in": "query",
            "required": false,
            "description": "The 'redirect_uri' that was registered for this client. It is required if multiple redirect_uri's have been registered for this client. If the scope contains openid, this field becomes MANDATORY.",
            "type": "string"
          },
          {
            "name": "scope",
            "in": "query",
            "required": false,
            "description": "Only SCOPE values that were registered for this client will be granted. If only non-matching SCOPE values are requested, the request will fail.",
            "type": "string"
          },
          {
            "name": "state",
            "in": "query",
            "required": false,
            "description": "Value opaque to the server, used by the client to track its session. It will be returned as received.",
            "type": "string"
          },
          {
            "name": "nonce",
            "in": "query",
            "required": false,
            "description": "This is required for response_type 'token id_token'. Typically, in an OpenID authorization scheme, the nonce represents a cryptographically strong random string that is used to prevent intercepted responses from being reused.",
            "type": "string"
          }
        ],
        "responses": {
          "200": {
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
          "302": {
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
          "400": {
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
            "description": "OpenID Discovery Configuration",
            "schema": {
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
              "$ref": "#/paths/~1info/get/responses/500/schema"
            }
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
            }
          },
          "500": {
            "description": "An error occurred",
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
    }
  }
}
