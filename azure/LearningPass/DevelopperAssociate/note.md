## CLI
----
- Cloud Shell
    - ポータル上のシェル 
    - `Bash`、`PowerShell`に対応
    - `code`コマンドが使える

## Azure App Service
---

### **概要**:
webアプリ構築用サービス

- webアプリ用サーバーの管理
- ホスティング
- OSのバージョン管理

### **IDプロバイダー**

ソーシャルログイン機能が組み込みで存在する

認証設定で、任意のSNSをアタッチすると
デプロイ時にソーシャルログイン用のコールバックが生成される

```js
"http://<yourazureappname>.azurewebsites.net/.auth/login/twitter/callback"
```


### **用語一覧**

- インスタンスタイプ
    - [公式ページ](https://azure.microsoft.com/ja-jp/pricing/details/app-service/linux/)

|タイプ名|概要|コンピューティングのリソース|
|:-:|:--|:--|
|Free|無料枠|共有|
|Shared|開発/テスト用|共有|
|Basic|開発/テスト用|専用|
|Standard|運用環境|専用|
|Premium|運用環境|専用|
|Isolated|運用環境|専用・Azure内のプライベートなネットワーク|

- Basic以上は単一のAppServiceプランのみのワークロードがworkerに実行される(専用のリソースが提供される)
- standardの場合、プラン内の全てのアプリが同じWorkerで実行される。スケールする際は、全アプリが新規のWorkerに移行される。
