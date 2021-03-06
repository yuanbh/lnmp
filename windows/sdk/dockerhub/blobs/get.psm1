Import-Module $PSScriptRoot/../utils/Get-SHA.psm1
Import-Module $PSScriptRoot/../cache/cache.psm1

function Get-Dist($dist, $distTemp) {
  if ($dist) {
    copy-item -force $distTemp $dist

    return $dist
  }

  return $distTemp
}

function _sha256_checker($filename) {
  $sha256 = (Get-ChildItem $filename).name.split('.')[0]
  $current_sha256 = Get-SHA256 $filename

  if ($sha256 -ne $current_sha256 ) {
    Write-Host "==> $filename sha256 check failed" -ForegroundColor Red

    return $false
  }

  return $true
}

function Get-Blob([string]$token, [string]$image, [string]$digest, [string]$registry = "registry.hub.docker.com", $dist) {
  $sha256 = $digest.split(':')[1]
  $prefix = $sha256.Substring(0, 2)
  New-Item -force -type Directory (Get-CachePath blobs/sha256/$prefix) | out-null
  $distTemp = Get-CachePath "blobs/sha256/$prefix/$sha256"

  if (Test-Path $distTemp) {
    if (_sha256_checker $distTemp) {
      Write-Host "==> File already exists, skip download" -ForegroundColor Green

      return Get-Dist $dist $distTemp
    }

    Write-Host "==> File already exists, but sha256 check failed, redownload" -ForegroundColor Red
  }

  try {
    $result = Invoke-WebRequest `
      -Authentication OAuth `
      -Token (ConvertTo-SecureString $token -Force -AsPlainText) `
      -Headers @{"Accept" = "application/vnd.docker.image.rootfs.diff.tar.gzip" } `
      "https://$registry/v2/$image/blobs/$digest" `
      -PassThru `
      -OutFile $distTemp `
      -UserAgent "Docker-Client/19.03.5 (Windows)"
  }
  catch {
    $result = $_.Exception.Response

    $statusCode = $result.StatusCode

    if (!$statusCode) {
      Write-Host $_.Exception
    }
    else {
      Write-Host "==> HTTP StatusCode is $statusCode" -ForegroundColor Red
    }

    if ($statusCode -lt 400 -and $statusCode -gt 200) {
      $url = $result.Headers.Location

      Write-Host "==> Redirect to $url"

      $result3xx = Invoke-WebRequest `
        "$url" `
        -PassThru `
        -OutFile $distTemp `
        -UserAgent "Docker-Client/19.03.5 (Windows)"
    }
    else {
      return $false
    }
  }

  $size = (($result.RawContentLength)/1024/1024)

  Write-Host "Download size is $('{0:n2}' -f $size) M" -ForegroundColor Green

  if (_sha256_checker $distTemp) {
    return Get-Dist $dist $distTemp
  }

  return $false
}

Export-ModuleMember -Function Get-Blob
