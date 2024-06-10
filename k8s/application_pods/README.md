secret_provider_class.yaml extracts the value associated with the key SECRET_TOKEN, and stores it in a Kubernetes Secret named api-token
    objects: |
      - objectName: My_Secret <--------- Name of the secret
        objectType: secretsmanager
        objectAlias: secret-token <-------------- Name of the file that gets mounted to pods

Needs to be placed in the same namespace (prod) as the service (application pods). 

In the deployment.yaml, you mount secrets as files:
      volumes:
      - name: my-api-token
        csi:
          driver: secrets-store.csi.k8s.io
          readOnly: true
          volumeAttributes:
            secretProviderClass: aws-secrets

And expose the secret as an environment variable:
        env:
        - name: API_TOKEN
          valueFrom:
            secretKeyRef:
              name: api-token
              key: SECRET_TOKEN

cluster_role.yaml allows the CSI Secrets Store provider access to service accounts, pods, and nodes. SCP can then manage and retrieve secrets securely from AWS Secrets Manager and make them available to the applications running in the cluster.