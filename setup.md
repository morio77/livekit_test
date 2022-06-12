---
marp: true
theme: default

---
# Flutter ✕ Livekit でオンライン会議アプリを作る

---
# アジェンダ
  - 自己紹介
  - 開発環境
  - 今回作るもの
  - 


---
# 自己紹介
  - C#でWindowsアプリケーションを作っているサラリーマン

---
# 開発環境など
  - MacOS：12.2.1
  - Flutter：Version 3.0.1
  - Ubuntu22.04 LTS (さくらのVPS様)

---
# 大まかな手順

- サーバの構築1(Livekitサーバ)
- サーバの構築2(Token処理サーバ)
- クライアントアプリの作成(Flutterアプリ)

---
# サーバの構築(Linux Server)

- dockerを使えるようにする
- LivekitのConfigファイルを生成する
- Livekitサーバを建てる
- 接続用アクセストークンを生成する

## 重要：セキュリティ対策などはしていないので、本番運用する場合は以下を参照ください  
https://docs.livekit.io/deploy/

---
# サーバの構築1(Linux Server)
  - dockerを使えるようにする
    - `sudo apt-get update`
    - `sudo apt-get upgrade`
    - `sudo apt-get install docker docker-compose`
  
---
# サーバの構築2(Linux Server) 
- LivekitのConfigファイルを生成する
    - `sudo docker run --rm -v$PWD:/output livekit/generate --local`
```bash
Unable to find image 'livekit/generate:latest' locally
latest: Pulling from livekit/generate
2408cc74d12b: Pull complete 
2e71611c8df9: Pull complete 
Digest: sha256:076d9b6a9079e3e23900819ca8cf997fb600aa6f2de044006a7061ba957ce624
Status: Downloaded newer image for livekit/generate:latest
Generated livekit.yaml that's suitable for local testing

Start LiveKit with:
docker run --rm \
    -p 7880:7880 \
    -p 7881:7881 \
    -p 7882:7882/udp \
    -v $PWD/livekit.yaml:/livekit.yaml \
    livekit/livekit-server \
    --config /livekit.yaml \
    --node-ip=127.0.0.1

Note: --node-ip needs to be reachable by the client. 127.0.0.1 is accessible only to the current machine

Server URL:  ws://localhost:7880
API Key: XXX
API Secret: YYY

Here's a test token generated with your keys: ZZZ
```  

---
# サーバの構築3(Linux Server) 
  - Livekitサーバを建てる
```bash
sudo docker run --rm -p 7880:7880 \
    -p 7881:7881 \
    -p 7882:7882/udp \
    -v $PWD/livekit.yaml:/livekit.yaml \
    livekit/livekit-server \
    --config /livekit.yaml \
    --node-ip <machine-ip>
```

※<machine-ip>はローカルで試す場合は`127.0.0.1`など。VPSで試す場合はグローバルIPアドレスを指定する。

---
# サーバの構築4(Linux Server) 
  - 接続用アクセストークンを生成する
```bash
sudo docker run --rm -e LIVEKIT_KEYS="<api-key>: <api-secret>" \
    livekit/livekit-server create-join-token \
    --room "<room-name>" \
    --identity "<participant-identity>"
```

---
# サーバの構築2-1(Token処理サーバ)

nodejsの実行環境と`livekit-server-sdk`のインストール

```bash
# node.jsとnpmをインストール
sudo apt-get install nodejs npm livekit-server-sdk

# node.jsを最新にするためのnコマンドのインストール
sudo npm install n -g

 # nコマンドでnodejs, npmのLTS版をインストールする
sudo n lts

# バージョン確認
node -v
v16.15.1

# livekit-server-sdkをインストール
sudo npm install livekit-server-sdk --save
```

---
# サーバの構築2-2(Token処理サーバ)

```bash
# Token処理サーバを作るディレクトリを作成
sudo mkdir /srv/token-server

# 移動して、nodeプロジェクトを作成
cd /srv/token-server
sudo npm init -y

#livekitSDK、express(webアプリ作成フレームワーク)をインストール
sudo npm install livekit-server-sdk --save
sudo npm install express
```

---
# サーバの構築2-3(Token処理サーバ)

クライアントからのリクエストを受け、livekit-server-sdkを使い、  
Tokenを生成しクライアントに返却するサーバを作成する。

`sudo touch app.js`

```javascript
import { AccessToken } from 'livekit-server-sdk';

const roomName = 'name-of-room';
const participantName = 'user-name';

const at = new AccessToken('api-key', 'secret-key', {
  identity: participantName,
});
at.addGrant({ roomJoin: true, room: roomName, canPublish: true, canSubscribe: true });

const token = at.toJwt();
console.log('access token', token);
```

---
# クライアントの作成(Flutter)