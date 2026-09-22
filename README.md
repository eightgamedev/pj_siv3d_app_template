# Ubuntu 用 Siv3D アプリケーションテンプレート

このプロジェクトでは、OpenSiv3D を Git サブモジュールとして管理します。
再利用する部品や、単体では実行しない関数は `src/` に置きます。
実際に起動して動作を確認するプログラムは `functional_test/` に置きます。
SDK は `third_party/OpenSiv3D` から共有します。

## src と functional_test の使い分け

- `src/`: 他のプログラムから呼び出す関数、クラス、共通処理を置きます。
    ここに置くファイルは、通常は単体で実行しません。
- `functional_test/`: `src/` の部品を組み合わせ、実際に起動して動作を確認する
    プログラムを置きます。画面表示、手動確認、機能の組み合わせテストなどが対象です。
- `build/`: CMake が生成するビルドファイルと実行ファイルを置きます。直接編集しません。

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

## src に部品を追加する

実行しない関数やクラスは `src/` に追加します。例えば `src/hello.cpp` と
`src/hello.h` のように、実装とヘッダーファイルを配置します。
`.cpp` ファイルは `src/CMakeLists.txt` の `app_components` に1行追加します。
ライブラリのリンク設定や include 設定をファイルごとに書く必要はありません。

```cmake
add_library(app_components STATIC
    hello/hello.cpp
    camera/camera.cpp
)
```

実行するプログラムからはヘッダーファイルを `#include` して利用します。
`app_components` は、このアプリで複数の実行プログラムから再利用する部品をまとめる
ライブラリです。機能テストでは `add_default_build()` が自動的にリンクします。

`src/` のファイル自体を直接実行するのではなく、呼び出し側の実行ファイルを
ビルドして動作を確認します。

実行ファイルは `build/bin/` に生成されます。

## functional_test に実行用プログラムを追加する

実際に起動するプログラムは `functional_test/` のサブフォルダに追加します。
テストごとに `CMakeLists.txt` と実行用ソースファイルを作成し、
`functional_test/CMakeLists.txt` に `add_subdirectory()` を追加します。

```text
functional_test/hello/
├── CMakeLists.txt
└── hello_test.cpp
```

`functional_test/CMakeLists.txt`:

```cmake
add_subdirectory(hello)
```

`functional_test/hello/CMakeLists.txt`:

```cmake
add_default_build(hello_test)
```

`hello_test.cpp` の例:

```cpp
#include "hello.h"

#include <iostream>
#include <string>

int main()
{
    const std::string result = hello::hello();
    std::cout << result << '\\n';

    return 0;
}
```

実行ファイルは `build/bin/hello_test` に生成されます。
変更後は、セットアップのビルド手順を実行し、最後に
`ctest --test-dir build --output-on-failure` でテストを実行します。

OpenSiv3D に必要な Ubuntu パッケージは別途インストールしてください。
詳しくは OpenSiv3D 公式の Linux ビルド手順を確認してください。
