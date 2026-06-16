#requires -Version 7
# Deploy do site thilia.pt para S3 + invalidacao do CloudFront.
# Uso: pwsh -NoProfile -File .\deploy.ps1

$ErrorActionPreference = 'Stop'

$Aws            = 'C:\Program Files\Amazon\AWSCLIV2\aws.exe'
$Profile        = 'scholion-admin'
$Bucket         = 'thilia-pt-site'
$DistributionId = 'E3AMLJLZ9BXUQR'
$Root           = $PSScriptRoot

Write-Host "==> Sync para s3://$Bucket"
& $Aws s3 sync $Root "s3://$Bucket" --profile $Profile `
    --exclude '.git/*' --exclude 'deploy.ps1' --exclude 'README.md' --delete

Write-Host "==> Invalidando CloudFront ($DistributionId)"
& $Aws cloudfront create-invalidation --distribution-id $DistributionId --paths '/*' --profile $Profile | Out-Null

Write-Host "OK."
