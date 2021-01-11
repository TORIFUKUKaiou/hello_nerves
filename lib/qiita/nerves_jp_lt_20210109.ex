defmodule Qiita.NervesJPLT20210109 do
  def run do
    Qiita.Api.patch_item(
      markdown(),
      false,
      [
        %{"name" => "Elixir"},
        %{"name" => "Phoenix"},
        %{"name" => "Nerves"}
      ],
      "Phoenixのdevcontainer (Elixir)",
      "636bb0a08d6a0b597a69"
    )
  end

  def markdown do
    """
    # はじめに
    - [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
    - この記事は、私の[Nerves](https://www.nerves-project.org/)アプリが書きました
        - [Nerves](https://www.nerves-project.org/)とは、
        - **NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです:rocket:**
    - [Phoenix](https://www.phoenixframework.org/)とは、[Elixir](https://elixir-lang.org/)でWebアプリをつくっていけるフレームワークです
    - devcontainerとは、[Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)のことを私は指していて
        - [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)と[Docker](https://www.docker.com/)でお手軽に開発環境を整えてしまいましょう :rocket::rocket::rocket: というものです
        - 具体例は、 @takasehideki 先生の「[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)」があります
    - で、私は今回、:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:の[Phoenix](https://www.phoenixframework.org/)版を作ってみたわけです

    # 2021/1/9(土) [NervesJP #14 新年LT回](https://nerves-jp.connpass.com/event/199455/)
    - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:の
    - <font color="purple">$\\huge{出し物}$</font>
    - です
    - どういうことかというと、 @kentaro さんの[kentaro/mix_tasks_upload_hotswap](https://github.com/kentaro/mix_tasks_upload_hotswap)デモとして、[Nerves](https://www.nerves-project.org/)アプリからこの記事をアップロードしてみたいとおもっていますですよ

    # devcontainer
    - 今回は、とあるフォルダ内に`.devcontainer`というフォルダを用意して以下3ファイルをつくります
    - [bolte-17/Phoenix-Devcontainer](https://github.com/bolte-17/Phoenix-Devcontainer)をベースにしました
        - 少し変えた部分はプルリクを送ってみましたです
        - [Install latest phx.new #1](https://github.com/bolte-17/Phoenix-Devcontainer/pull/1)
        - [mount data/ on project root. #2](https://github.com/bolte-17/Phoenix-Devcontainer/pull/2)

    ```json:.devcontainer/devcontainer.json
    // For format details, see https://aka.ms/vscode-remote/devcontainer.json or this file's README at:
    // https://github.com/microsoft/vscode-dev-containers/tree/v0.106.0/containers/elm
    {
      "name": "Elixir & Node.js 12 & PostgresSQL",
      "dockerComposeFile": "docker-compose.yml",
      "service": "web",
      "workspaceFolder": "/workspace",

      // Set *default* container specific settings.json values on container create.
      "settings": {
        "terminal.integrated.shell.linux": "/bin/bash"
      },

      // Add the IDs of extensions you want installed when the container is created.
      "extensions": [
        "elixir-lsp.elixir-ls",
      ]

      // Uncomment the next line if you want start specific services in your Docker Compose config.
      // "runServices": [],

      // Uncomment the line below if you want to keep your containers running after VS Code shuts down.
      // "shutdownAction": "none",

      // Use 'postCreateCommand' to run commands after the container is created.
      // "postCreateCommand": "yarn install",

      // Uncomment to connect as a non-root user. See https://aka.ms/vscode-remote/containers/non-root.
      // "remoteUser": "node"
    }
    ```

    ```docker:.devcontainer/Dockerfile
    # Elixir + Phoenix

    FROM elixir:1.9

    ENV DEBIAN_FRONTEND=noninteractive

    # Install debian packages
    RUN apt-get update
    RUN apt-get install --yes build-essential inotify-tools postgresql-client

    # Install Phoenix packages
    RUN mix local.hex --force
    RUN mix local.rebar --force
    RUN mix archive.install hex phx_new --force

    # Install node
    RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
    RUN bash nodesource_setup.sh
    RUN apt-get install -y nodejs

    ENV DEBIAN_FRONTEND=dialog

    WORKDIR /app
    EXPOSE 4000
    ```

    ```docker:.devcontainer/docker-compose.yml
      version: '3'
      services:
        web:
          # Uncomment the next line to use a non-root user for all processes. You can also
          # simply use the "remoteUser" property in devcontainer.json if you just want VS Code
          # and its sub-processes (terminals, tasks, debugging) to execute as the user. On Linux,
          # you may need to update USER_UID and USER_GID in .devcontainer/Dockerfile to match your
          # user if not 1000. See https://aka.ms/vscode-remote/containers/non-root for details.
          # user: node

          build:
            context: .
            dockerfile: Dockerfile

          volumes:
            - ..:/workspace:cached

          # Overrides default command so things don't shut down after the process ends.
          command: sleep infinity

          links:
            - db

        db:
          image: postgres
          restart: unless-stopped
          ports:
            - 5432:5432
          environment:
            POSTGRES_PASSWORD: postgres
            POSTGRES_USER: postgres
          volumes:
            - ./../data/db:/var/lib/postgresql/data
    ```

    # 使い方
    - @takasehideki 先生の「[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する #導入手順](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#%E5%B0%8E%E5%85%A5%E6%89%8B%E9%A0%86)」を参考に、インストールを進めます
        - [Visual Studio Code](https://code.visualstudio.com/download)
            - 拡張機能[Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
        - [Docker Desktop](https://www.docker.com/products/docker-desktop)
    - あとは[Visual Studio Code](https://code.visualstudio.com/download)で、**Remote-Containers: Open Folder in Container...** から`.devcontainer`があるフォルダを選べばいいです
        - 具体的には、これも@takasehideki 先生の「[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する #2. VS Codeをdev-container機能で開く](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#2-vs-code%E3%82%92dev-container%E6%A9%9F%E8%83%BD%E3%81%A7%E9%96%8B%E3%81%8F)」をご参照ください
            - [コーヒーを淹れる:coffee:](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#3-%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC%E3%82%92%E6%B7%B9%E3%82%8C%E3%82%8Bcoffee)が一番重要だと個人的にはおもっています
            - 気長に待つ必要があります
            - [コーヒーを淹れる:coffee:](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#3-%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC%E3%82%92%E6%B7%B9%E3%82%8C%E3%82%8Bcoffee)は、@takasehideki 先生の記事中での表現です :joy::joy::joy::joy::joy:

    ![スクリーンショット 2021-01-09 15.34.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/63ddeaaa-a162-00cd-4d8c-445036c0d982.png)

    左下が`>< Dev Container: Elixir & Node.js 12 & PostgreSQL`な感じになっていたら成功です



    # helloプロジェクト作成

    - [Visual Studio Code](https://code.visualstudio.com/download)付属のターミナルで操作します
    - もし表示されていない場合は、`Terminal > New Terminal`を選んでください

    ```
    /workspace# mix phx.new hello
    /workspace/hello# cd hello
    ```

    - `mix phx.new hello`で`Fetch and install dependencies? [Yn]`を聞かれたら、`No`と言える日本人でありたいとおもいます
    - [Visual Studio Code](https://code.visualstudio.com/download)で編集できますので

    ```elixir:hello/config/dev.exs
    config :hello, Hello.Repo,
      username: "postgres",
      password: "postgres",
      database: "hello_dev",
      hostname: "db",
      show_sensitive_data_on_connection_error: true,
      pool_size: 10
    ```

    ![スクリーンショット 2021-01-09 15.41.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/adeea5df-45dc-f2aa-22c7-c43d01ec68fd.png)


    - `hostname: "db"`と変更いたしましたですよ、


    ```
    /workspace/hello# mix setup
    /workspace/hello# mix phx.server
    ```

    - Visit: http://localhost:4000

    ![スクリーンショット 2021-01-09 15.51.01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/40bb2958-7cd8-2d6c-120a-3377b9812afe.png)


    :tada::tada::tada:

    # Wrapping Up 🎍🎍🎍🎍🎍
    - うまくいったかな :interrobang::interrobang::interrobang:
    - ありがとナイス:flag_cn:
    - とにかく[Elixir](https://elixir-lang.org/)に関係あることは[Qiita](https://qiita.com/)にアウトプットしていくスタイル
        - ありがとうございます！！！！
    - Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:


    """
  end
end
