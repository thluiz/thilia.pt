# thilia.pt

Site estático de `thilia.pt`. Página "Em Breve" servida via **S3 + CloudFront**.

## Infraestrutura (AWS, conta `137566891486`, profile `scholion-admin`)

- **S3** (origin privado): `thilia-pt-site` (us-east-1), acesso só via CloudFront (OAC)
- **CloudFront**: distribuição com IPv6, alternate domains `thilia.pt` + `www.thilia.pt`
- **ACM** (us-east-1): cert para `thilia.pt` + `www.thilia.pt`, validação DNS
- **DNS**: Cloudflare (apex + `www` → CloudFront). MX/SPF/DKIM/DMARC do email ficam intactos.

### Recursos criados

| Recurso | Identificador |
|---|---|
| S3 bucket | `thilia-pt-site` (us-east-1) |
| CloudFront | `E3AMLJLZ9BXUQR` — `d10yz1d94teezw.cloudfront.net` |
| OAC | `E16DXGX13MZGTT` |
| ACM cert | `arn:aws:acm:us-east-1:137566891486:certificate/e7647bc3-24d1-4a73-a90d-ba1291d8919c` |

## Deploy

```powershell
pwsh -NoProfile -File .\deploy.ps1
```

Faz `aws s3 sync` do conteúdo e invalida o cache do CloudFront.
