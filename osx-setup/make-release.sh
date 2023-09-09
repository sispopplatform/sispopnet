#!/bin/sh
VERSION=$1

echo "Copying latest build"
mkdir -p osx-pkg/usr/local/bin
mkdir osx-pkg/usr/local/lib
cp ../sispopnet osx-pkg/usr/local/bin
echo "Copying /usr/local/lib/libuv.dylib into package"
cp /usr/local/lib/libuv.dylib osx-pkg/usr/local/lib
# just incase they want to switch networks later
cp ../sispopnet-bootstrap osx-pkg/usr/local/bin

echo "Building package $VERSION"
mkdir -p pkg1
rm pkg1/sispopnet.pkg
pkgbuild --root osx-pkg --scripts scripts --identifier network.sispop.sispopnet --version $VERSION pkg1/sispopnet.pkg
rm sispopnet-v$VERSION.pkg
productbuild --distribution distribution.xml --resources resources --package-path pkg1 --version $VERSION sispopnet_macos64_installer_v$VERSION.pkg

