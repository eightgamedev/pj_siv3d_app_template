# Ubuntu 用 Siv3D アプリケーションテンプレート

このプロジェクトでは、OpenSiv3D を Git サブモジュールとして管理します。
アプリケーションのソースファイルは `functional_test/` に置き、SDK は
`third_party/OpenSiv3D` から共有します。

## セットアップ

```bash
git submodule update --init --recursive
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j
```

Siv3D が `resources` ディレクトリを見つけられるように、ビルド後の実行ファイルを
起動します。

```bash
./build/bin/siv3d_app
```

## ソースファイルを追加する

アプリケーションのソースファイルは `functional_test/` に追加します。
アプリケーションに含めてビルドするには、
`functional_test/CMakeLists.txt` の `add_executable()` にファイル名を追加します。

```cmake
add_executable(siv3d_app Main.cpp Player.cpp)
```

その後、プロジェクトを再構成してビルドします。

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --target siv3d_app -j
```

実行ファイルは `build/bin/siv3d_app` に生成されます。
`build/` は CMake が生成するディレクトリなので、直接編集しないでください。

## 機能テストを追加する

テストごとにサブフォルダを作成し、その中に `CMakeLists.txt` とソースファイルを
追加してください。`functional_test/CMakeLists.txt` に
`add_subdirectory()` を追加すると、明示的にテストを登録できます。

```text
functional_test/input_test/
├── CMakeLists.txt
└── hello_test.cpp
```

`functional_test/CMakeLists.txt`:

```cmake
add_subdirectory(input_test)
```

`functional_test/input_test/CMakeLists.txt`:

```cmake
add_default_build(input_test)
```

`input_test.cpp` の例:

```cpp
int main()
{
    return 0;
}
```

実行ファイルは `build/bin/input_test` に生成されます。
登録したテストは、次のコマンドでまとめてビルド・実行できます。

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j
ctest --test-dir build --output-on-failure
```

OpenSiv3D に必要な Ubuntu パッケージは別途インストールしてください。
詳しくは OpenSiv3D 公式の Linux ビルド手順を確認してください。
