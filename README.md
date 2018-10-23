# balance change script for mod_proxy_balancer

Apacheの mod_proxy_balancerのAPサーバの切り替えを簡単に行えるシェルスクリプトです。

## 設定
*ベーシック認証をかけている場合

AC,PASS それぞれにベーシック認証のアカウント、パスワードを設定

application - ProxyPassにて設定したパス

ARR_WEB_SVR - Apacheが動いているサーバーのIP(複数可能)

ARR_AP_SVR - Application(ここではTomcat)が動いているサーバーのIP(複数可能)

## 使用法

### 現在の状況を表示する

change_lb.sh (パラメータなし)

### turn on

change_lb.sh enable 1(apサーバー1)

### turn off

change_lb.sh disable 1(apサーバー1)
