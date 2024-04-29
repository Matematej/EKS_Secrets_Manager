secret_provider_class.yaml extracts the value associated with the key SECRET_TOKEN, and stores it in a Kubernetes Secret named api-token
    objects: |
      - objectName: prod/service/token <--------- Name of the secret
        objectType: secretsmanager
        objectAlias: My_Secret <-------------- Name of the file that gets mounted to pods