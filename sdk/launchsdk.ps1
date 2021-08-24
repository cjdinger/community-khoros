Write-Host "Launch Khoros SDK"

If ($args.count -ne 1) {
$IMAGE="khoros-sdk:1.0"
Write-Host "launchsdk.ps1: $IMAGE"
}else {
$IMAGE=$args[0]
}

$run_args="-u sdkuser " +
"--name khoros_sdk " +
"-it --rm " +
"--volume '$pwd\plugins:/home/sdkuser/plugins' " 

$cmd="docker run $run_args $IMAGE"
$dockercmd="& $cmd"

Write-Host $dockercmd

Invoke-Expression $dockercmd

