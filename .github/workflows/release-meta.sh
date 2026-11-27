set -euo pipefail
tag=meta
# the release is created once by hand; a missing one is not an error worth
# stopping for, but a failed upload is, because the site would keep the old zip
gh release view "$tag" --repo SpikyTeam/spiky-meta-staging >/dev/null \
  || gh release create "$tag" --repo SpikyTeam/spiky-meta-staging --title meta \
       --notes "The launcher metadata bundle: meta-v1.zip, rebuilt by every push here."
# release assets cannot be replaced, so the old one goes first
gh release delete-asset --repo SpikyTeam/spiky-meta-staging --yes "$tag" meta-v1.zip || true
gh release upload --repo SpikyTeam/spiky-meta-staging "$tag" /tmp/meta-v1.zip
