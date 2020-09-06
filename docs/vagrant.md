# Vagrant起動手順
## VirtualBoxダウンロード
* 下記アドレスで自身のOSを選択しダウンロード(platform packages + VM VirtualBox Extension Pack)+実行
    * https://www.virtualbox.org/wiki/Downloads


* 下記コマンドでインストール確認(Win, Mac共通)
    ```
    VBoxManage -v
    (バージョンが表示されればOK)
    ```


## Vagrantダウンロード
* 下記アドレスで自身のOSを選択しダウンロード+実行
    * https://www.vagrantup.com/downloads.html
* 下記コマンドでインストール確認(Win, Mac共通)
    ```
    vagrant -v
    (バージョンが表示されればOK)
    ```



## Vagrant 起動(Win, Mac共通)
* インターン用boxと配布Vagrantfileを同ディレクトリに設置
* Vagrantfileを編集する
    ```
    vb.customize [ "modifyvm", :id, "--uartmode1", "file", "/PATH/console.log" ] 
    # PATHを任意のディレクトリに変更(Vagrantfileと同ディレクトリがオススメ)
    ```
* 下記コマンドで起動、接続する
    ```
    vagrant up
    vagrant ssh
    ```

## etc/hosts設定(Host作業)
* hostファイルに下記を追加する
    ```
    192.168.33.189 summer2022.intern.local
    ```    
* Mac
    * /etc/hosts
* Windows10
    * C:Windows¥System32¥drivers¥etc¥hosts

## gitclone(vagrant内作業)
* gitのssh接続設定(helpに参考ページ)
* `git clone git@github.com:satori-inc/satori_intern_2022.git`

## Rails起動(vagrant内作業)
* node修正
    * 下記コマンドを入力
    ```
    nvm unalias v12.18.3
    nvm use default
    ```
* rails 起動
    * (satori_intern_2022)下記コマンドを入力
    ```
    rails yarn:install
    rails db:create
    rails s
    ```
* ブラウザから( https://summer2022.intern.local/static_pages/home )にアクセス
    * chromeだと証明書で弾かれる可能性あり


## help
1. Windowsでバージョンが表示されない
    * pathが通っていないためインストールディレクトリを登録してください
        * (参考)デフォルトインストールディレクトリ: `C:\Program Files\Oracle\VirtualBox`
2. GitHubでssh接続
    * https://qiita.com/shizuma/items/2b2f873a0034839e47ce
