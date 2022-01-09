# counter

Simple counter SAM application

## Requirements

* SAM CLI
* AWS resources:
    * Route53 hosted zone in which the custom endpoint "counter" is created
    * ACM Certificate to be used for custom endpoint

## Deploy

```
sam deploy --guided
```

Parameters:

* HostedZoneId: The ID of hosted zone in which "counter" record is created
* DomainName: The domain name of hosted zone
* CertificateArn: ARN for certificate used by the custom endpoint

You can access the counter by `https://counter.${DomainName}/`
