# Siv3D application template for Ubuntu

This project keeps OpenSiv3D as a git submodule. Applications live in `src/`
and `functional_test/`, while the SDK is shared from `third_party/OpenSiv3D`.

## Setup

```bash
git submodule update --init --recursive
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j
```

Run the application from the build output directory so Siv3D can find its
`resources` directory:

```bash
./build/bin/siv3d_app
```

The Ubuntu packages required by OpenSiv3D must be installed separately as
described in the official Linux build documentation.