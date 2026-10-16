#!/bin/bash -Eeu

# Fix up broken gfortran (which boost depends on) redirects
# https://www.gitmemory.com/issue/docker-library/gcc/57/499172974
dpkg-divert --remove --no-rename /usr/bin/gfortran
dpkg-divert --divert /usr/bin/gfortran.orig --rename /usr/local/bin/gfortran
apt install --yes libblas-dev

# Install boost
apt-get install --yes libboost-dev libboost-all-dev
apt-get install --yes wget

# Install the newest GSL release. GitHub redirects releases/latest to the
# newest release's tag, which is resolved here at build time so a rebuild
# picks up the next release by itself. GSL is header-only, so its include
# directory is all a kata needs.
readonly GSL_LATEST_URL=$(curl --silent --fail --output /dev/null --write-out '%{redirect_url}' \
  https://github.com/microsoft/GSL/releases/latest)
readonly GSL_TAG="${GSL_LATEST_URL##*/}"

# An empty tag means the redirect could not be read or has changed shape,
# not that GSL stopped releasing, so stop rather than install nothing.
if [ -z "${GSL_TAG}" ]; then
  echo 'Found no GSL release tag at github.com/microsoft/GSL' >&2
  exit 1
fi

curl --silent --fail --location \
  "https://github.com/microsoft/GSL/archive/refs/tags/${GSL_TAG}.tar.gz" \
  | tar --extract --gzip --directory /usr/local --strip-components 1 "GSL-${GSL_TAG#v}/include"

# No start point's own files include GSL, so their tests never compile it.
# Compiling its umbrella header here is what stops a release the installed
# g++ cannot build from reaching a learner.
echo '#include <gsl/gsl>' | g++ -fsyntax-only -x c++ -

# Install Fake Function Framework
cd /usr/local/include
wget https://raw.githubusercontent.com/meekrosoft/fff/master/fff.h
apt-get remove --yes wget

# Install gcovr
apt-get install --yes gcovr

# Records the C++ this image holds, in the shape every image shares. The
# installed compiler is asked, so the version is one the image can run rather
# than one written down when someone last edited this file. -dumpfullversion
# prints the version alone, where --version prints a sentence around it.
readonly LANGUAGE_VERSION=$(g++ -dumpfullversion)

if [ -z "${LANGUAGE_VERSION}" ]; then
  echo 'Could not read a version from g++ -dumpfullversion' >&2
  exit 1
fi

cat > /versions.json <<EOF
{
  "language": {
    "name": "C++ (g++)",
    "version": "${LANGUAGE_VERSION}"
  },
  "test_frameworks": []
}
EOF
