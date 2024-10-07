#!/bin/bash

# Find all .terraform.lock.hcl files that have been modified or added to the staging
staged_lock_files=$(git status --porcelain | grep '[AM][ ]*s.*.terraform.lock.hcl$' | awk '{print $2}')

if [[ -z "$staged_lock_files" ]]; then
  echo "No .terraform.lock.hcl files to process."
  exit 0
fi

# Run terraform providers lock in each directory containing a .terraform.lock.hcl file
for lockfile in $staged_lock_files; do
  dir=$(dirname "$lockfile")

  echo "Run terraform providers lock in: $dir"

  # Go to the directory
  cd "$dir" || exit

  # Run terraform providers lock
  terraform providers lock \
    -platform=windows_amd64 \
    -platform=darwin_amd64 \
    -platform=darwin_arm64 \
    -platform=linux_amd64

  # Return to the previous directory
  cd - > /dev/null
done