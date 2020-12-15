#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset

# Get the internal clister IP
export TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
INTERNAL_IP=$(curl -H "Authorization: Bearer $TOKEN" -k -Ssl https://kubernetes.default/api |
jq -r '.serverAddressByClientCIDRs[0].serverAddress')

# Replace CLUSTER_IP in the rewrite filter and action file
sed -i "s/CLUSTER_IP/${INTERNAL_IP}/g" \
    /etc/privoxy/k8s-rewrite-external.filter
sed -i "s/CLUSTER_IP/${INTERNAL_IP}/g" \
    /etc/privoxy/k8s-only.action

cat /etc/privoxy/k8s-rewrite-external.filter

# Start privoxy un-daemonized
privoxy --no-daemon /etc/privoxy/privoxy.conf