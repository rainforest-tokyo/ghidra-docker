# ghidra-docker
Ghidra

Dockerの作成・起動

```
$ sudo bash
$ docker build -t <Docker Image名> .
$ docker run -it -d --name ghidra <Docker Image名>
$ docker ps
```

Decompileの実行

```
$ sudo bash
$ ghidra.sh <検体のパス> <結果ソースファイル出力ディレクトリ>
```

ファイルの説明

```ja
├── Dockerfile // Docker File
├── LICENSE
├── README.md
├── ghidra.sh // Decompile実行スクリプト
└── scripts
    ├── Decompile2.java // headless decompile sample
    └── decomple.sh // Docker内でghidraを動作させるShell
```

