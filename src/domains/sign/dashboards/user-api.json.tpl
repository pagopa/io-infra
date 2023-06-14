{
  "lenses": {
    "0": {
      "order": 0,
      "parts": {
        "0": {
          "position": {
            "x": 0,
            "y": 0,
            "colSpan": 9,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${website_id}"
                        },
                        "name": "HealthCheckStatus",
                        "aggregationType": 3,
                        "namespace": "microsoft.web/sites",
                        "metricVisualization": {
                          "displayName": "Health check status",
                          "resourceDisplayName": "${website_name}"
                        }
                      }
                    ],
                    "title": "Max Health check status for ${website_name}",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
                      },
                      "axisVisualization": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      },
                      "disablePinning": true
                    }
                  }
                }
              }
            }
          }
        },
        "1": {
          "position": {
            "x": 9,
            "y": 0,
            "colSpan": 9,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "resourceTypeMode",
                "isOptional": true
              },
              {
                "name": "ComponentId",
                "isOptional": true
              },
              {
                "name": "Scope",
                "value": {
                  "resourceIds": [
                    "${application_insights_id}"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "10ef96d0-047b-49e7-b232-17ca611752c9",
                "isOptional": true
              },
              {
                "name": "Version",
                "value": "2.0",
                "isOptional": true
              },
              {
                "name": "TimeRange",
                "value": "P1D",
                "isOptional": true
              },
              {
                "name": "DashboardId",
                "isOptional": true
              },
              {
                "name": "DraftRequestParameters",
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "customEvents\n| where name in (\"sr_start\", \"sr_end\")\n| summarize span = datetime_diff('second', max(timestamp), min(timestamp)), stamp = max(timestamp) by tostring(customDimensions[\"sr_id\"])\n| summarize avg(span) by bin(stamp, 10m)\n",
                "isOptional": true
              },
              {
                "name": "ControlType",
                "value": "AnalyticsGrid",
                "isOptional": true
              },
              {
                "name": "SpecificChart",
                "isOptional": true
              },
              {
                "name": "PartTitle",
                "value": "Analytics",
                "isOptional": true
              },
              {
                "name": "PartSubTitle",
                "value": "tracing-test",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "isOptional": true
              },
              {
                "name": "LegendOptions",
                "isOptional": true
              },
              {
                "name": "IsQueryContainTimeRange",
                "value": false,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {
              "content": {
                "Query": "customEvents\n| where name in (\"sr_start\", \"sr_end\")\n| summarize span = datetime_diff('second', max(timestamp), min(timestamp)), maxts = max(timestamp) by tostring(customDimensions[\"sr_id\"])\n| summarize avg(span) by bin(maxts, 10m)\n| render timechart with (xtitle = \"timestamp\", ytitle= \"span\")\n\n",
                "ControlType": "FrameControlChart",
                "SpecificChart": "Line",
                "PartTitle": "Average time to signature (QTSP)",
                "Dimensions": {
                  "xAxis": {
                    "name": "maxts",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "avg_span",
                      "type": "real"
                    }
                  ],
                  "splitBy": [],
                  "aggregation": "Sum"
                },
                "LegendOptions": {
                  "isEnabled": true,
                  "position": "Bottom"
                }
              }
            }
          }
        }
      }
    }
  },
  "metadata": {
    "model": {
      "timeRange": {
        "value": {
          "relative": {
            "duration": 24,
            "timeUnit": 1
          }
        },
        "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
      },
      "filterLocale": {
        "value": "en-us"
      },
      "filters": {
        "value": {
          "MsPortalFx_TimeRange": {
            "model": {
              "format": "utc",
              "granularity": "auto",
              "relative": "24h"
            },
            "displayCache": {
              "name": "UTC Time",
              "value": "Past 24 hours"
            },
            "filteredPartIds": [
              "StartboardPart-MonitorChartPart-848751f8-b69f-4738-b901-8d7bd721c00a",
              "StartboardPart-LogsDashboardPart-848751f8-b69f-4738-b901-8d7bd721c00e"
            ]
          }
        }
      }
    }
  }
}
