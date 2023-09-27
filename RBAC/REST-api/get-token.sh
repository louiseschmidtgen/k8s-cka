APISERVER=$(kubectl config view --minify -o \
    jsonpath='{.clusters[0].cluster.server}')
# https://127.0.0.1:52821

TOKEN=$(kubectl get secret $(kubectl get serviceaccount api-access -n apps \
    -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' -n apps |
    base64 --decode)

echo $TOKEN
echo $APISERVER

curl $APISERVER/api/v1/namespaces/rm/pods --header \
    "Authorization: Bearer $TOKEN" \
    --insecure

echo curl $APISERVER/api/v1/namespaces/rm/pods --header \
    "Authorization: Bearer $TOKEN" \
    --insecure

curl https://localhost:52821/api/v1/namespaces/rm/pods --header "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImRnSW95NzVqYkRfdmJYeHpFUHlLQnpmRlJlOXV1TG1feXNUZ29WOERPd3MifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJhcHBzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InNlcnZpY2UtYWNjb3VudC1hcGktYWNjZXNzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFwaS1hY2Nlc3MiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI4ZTUxYzI4OC1mOGFhLTRhOTAtYmM3OC1mZmY1OWEzZGY3ZTIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6YXBwczphcGktYWNjZXNzIn0.YawCryifVxjWGfeiSLnKaB7d--kfiZibo-UnQQsk525xRbGgbPyFsxkcJ5crAYeVRyUhB1jXKnNI48jEUSf0FMgAP-FBH7h2IKw9G_Rc_nVBiG2RLF1Vilo7uOV3pseR9dig6MHWNA_OcHOQAgUEU1hz-u6_SU3bB6jKsf_Q8Ti7Pz-bRSZtMB5ghmLfOxCJiuOuZGCmDkbNTkbZP_ncYT0YbsV4qwLVA8QhRZxifXKptkTaLMjH66NO-IwgPqboDHnxoxKk_CpTW0S4zw767hZ6RPnDUDDKbcro-iWzlxn7zWQzxR1WX65H7YGEc0Dy0kCFC5UAp1wykSrgHkpxLg" --insecure
