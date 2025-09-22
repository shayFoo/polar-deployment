# Kubernetes 用語
[公式ドキュメント](https://kubernetes.io/ja/docs/reference/glossary/?fundamental=true)
## Pod

> Pods are the smallest deployable units in Kubernetes.

Pod は Kubernetes で管理、スケジューリングされる最小単位である。Pod の中には基本的に一つのコンテナが入っているが、複数のコンテナが入る場合もある。

公式

> Pod
>
> 一番小さく一番シンプルな Kubernetes のオブジェクト。Pod とはクラスターで動作しているいくつかのコンテナのまとまりです。
>
> 通常、Pod は一つの主コンテナを実行するように設定されます。ロギングなどの補足機能を付加する、取り外し可能なサイドカーコンテナを実行することもできます。Pod は通常 Deployment によって管理されます。

## Deployment

公式

> Deployment
>
> 複製されたアプリケーションを管理する API オブジェクトで、通常はステートレスな Pod を実行します。
>
> 各レプリカは Pod で表され、Pod はクラスターのノード間で分散されます。 ローカル状態を要求するワークロードには、StatefulSet の利用を考えてください。

### わかりやすく言い換え

- Deploymentとは何か

Kubernetesの中で「アプリをどう動かすか」を管理する仕組み。Kubernetes上ではオブジェクトの一つ。

具体的には「同じアプリを何個動かすか」「壊れたら自動で直すか」などを設定する。

直接Podを管理するのではなくて、Deploymentを通じて管理をする
- ステートレスなPodを実行する

Deploymentは、アプリの「使い捨てバージョン」を動かすのに向いている。

「ステートレス」とは、そのアプリが内部にデータや状態を持たず、壊れても作り直せば問題ないタイプのものを指す。
例: Webサーバー（Nginx, Apache, Node.jsアプリなど）

- 各レプリカはPodで表される（レプリカ＝Pod）

Deploymentで「3つコピーを動かしたい」と指定すると、3つのPodが作られる。

Pod = アプリの1つ分を入れた箱。

Replicasetsというオブジェクトで、一つのPodが壊れても、その代わりのPodが後に起動される。

- Podはクラスターのノード間で分散される

Kubernetesクラスターには複数のサーバー（ノード）がある。

Podはそのノードの上に割り振られて動く。つまり、負荷分散や冗長性が確保される。

- StatefulSetを使う場合

もしアプリが「状態（データや固有のIDなど）」を必要とする場合、DeploymentではなくStatefulSetを使う。

例: データベース（MySQL, PostgreSQL, MongoDBなど）


