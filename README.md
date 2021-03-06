# node-request-promise-demo

此demo是透過node-js套件[request-promise-native]每秒送request，並解析response的請求耗時，寫成log，再透過shell script分析log查出慢秒狀態

* dns: DNS lookup 花費的時間
* wait: socket 初始化花費的時間
* tcp: TCP connection 花費的時間
* firstByte: HTTP server response 花費的時間
* download: HTTP download 花費的時間)
* total: 全部花費的時間

## quick start
1. 安裝node-js所需套件
```shell
npm install --save request
npm install --save request-promise-native
```

2. 設定url
找到req.js裡的options，修改裡面的url，method等等的資訊

3. 執行方式
有兩種啟動方式，一種是直接下node req.js，另一種是跑在背景
    1. 直接執行：
       ```shell
        node req.js
       ``` 
    2. 跑背景
        ```shell
        ./monitor.start
        ```
        >如需寫入nohub的log可在monitor_start.sh的nohup node req.js & 後面接上 >> path/nohub.log 2>&1 &

4. script使用方式

總共有五個script能使用，直接下./sortxxx即可執行，根據提示進行操作即可。

其中有一份是叫log_anal.sh，以下簡單介紹使用方式
```shell
# 簡單做ip時段排序
./log_anal.sh path/your_log

# 針對特定時段查詢出現的ip
./log_anal.sh path/your_log "yyyy-mm-dd HH:MM:ss"
```
## 參考資料
* [ request-promise-native - npm (npmjs.com)](https://www.npmjs.com/package/request-promise-native)
* [DNS | Node.js v16.8.0 Documentation (nodejs.org)](https://nodejs.org/api/dns.html#dns_dns_lookup_hostname_options_callback)