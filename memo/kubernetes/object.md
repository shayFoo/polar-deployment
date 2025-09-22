# Kubernetesのオブジェクト
[公式ドキュメント](https://kubernetes.io/docs/concepts/overview/working-with-objects/)

- spec
    - オブジェクトが持っていてほしい「理想の状態」を定義
    - yamlファイルのspecで指定している
- status
    - オブジェクトの「現在の状態」
    - Kubernetesはstatusがspecに近づくようにオブジェクトを管理

