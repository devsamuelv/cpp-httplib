# The items in the curly brackets are function parameters as this is a Nix
# function that accepts dependency inputs and returns a new package
# description
{
  lib,
  stdenv,
  cmake,
  brotli,
}:

# stdenv.mkDerivation now accepts a list of named parameters that describe
# the package itself.

stdenv.mkDerivation {
  name = "cpp-httplib";

  # good source filtering is important for caching of builds.
  # It's easier when subprojects have their own distinct subfolders.
  src = ./.;

  # We now list the dependencies similar to the devShell before.
  # Distinguishing between `nativeBuildInputs` (runnable on the host
  # at compile time) and normal `buildInputs` (runnable on target
  # platform at run time) is an important preparation for cross-compilation.
  nativeBuildInputs = [ cmake ];
  buildInputs = [
    brotli
  ];

  # Instruct the build process to run tests.
  # The generic builder script of `mkDerivation` handles all the default
  # command lines of several build systems, so it knows how to run our tests.
  doCheck = true;
}
