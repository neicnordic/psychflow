#!/bin/bash

if [[ "$1" =~ ^(help|-h|--help)$ ]]; then
  echo "Buildfile prefetcher. Run prior to build to saves build files to cache dir."
  echo "Docker build will prefer using local files if present."
  exit 0
fi

cd $(dirname $0)
. vars.sh
pushd cache/

error=0
prefetch() {
  wget --continue $1
  ((error = $error || $?))
}

prefetch $rstudio_url
prefetch $ricopili_url
prefetch $liftover_url
prefetch $metal_url
prefetch $shapeit_url
prefetch $impute_url
prefetch $plink_url
prefetch $eigensoft_url
prefetch $eagle_url

popd
if [ "$error" -eq 0 ]; then
  echo "Done!"
else
  echo "ERROR: Not all files could be downloaded. Retry later maybe?"
fi