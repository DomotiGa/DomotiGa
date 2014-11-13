#!/bin/sh
curl -sS -X POST -H "Content-Type: application/json" -d '{"jsonrpc": "2.0", "method": "razberry.updatesready", "id": 1}' localhost:9090
