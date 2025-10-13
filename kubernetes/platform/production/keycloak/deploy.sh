#!/bin/sh

set -euo pipefail

echo "\n🗝️  Keycloak deployment started.\n"

echo "📦 Installing Keycloak..."

clientSecret=$(echo $RANDOM | openssl md5 | head -c 20)

kubectl apply -f resources/namespace.yml
sed "s/polar-keycloak-secret/$clientSecret/" resources/keycloak-config.yml | kubectl apply -f -

echo "\n📦 deploy keycloak."

kubectl apply -f resources/keycloak-deployment.yml
kubectl apply -f resources/keycloak-service.yml
kubectl apply -f resources/keycloak-ingress.yml

sleep 15

while [ $(kubectl get pod -l app=keycloak  | wc -l) -eq 0 ] ; do
  sleep 15
done

echo "\n⌛ Waiting for Keycloak to be ready..."

kubectl wait \
  --for=condition=ready pod \
  --selector=app=polar-keycloak \
  --namespace=keycloak-system \
  --timeout=600s \

echo "\n✅  Keycloak cluster has been successfully deployed."

echo "\n🔐 Your Keycloak Admin credentials...\n"

kubectl create secret generic polar-keycloak-client-credentials \
    --from-literal=spring.security.oauth2.client.registration.keycloak.client-secret="$clientSecret"

echo "\n🍃 A 'polar-keycloak-client-credentials' has been created for Spring Boot applications to interact with Keycloak."

echo "\n🗝️  Keycloak deployment completed.\n"
