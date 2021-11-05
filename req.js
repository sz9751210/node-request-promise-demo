const requestPromise = require("request-promise-native");
const fs = require("fs");
var data = new Array();
const dir = "./logs/req.log";

// request option
const options = {
  uri: "uri",
  method: "method",
//   time: true,
//   json: true,
  headers: {
    "Content-Type": "application/x-www-form-urlencoded",
    // "Content-Length": 562,
  },
  body: "body",
};

// parse data
function parse_data(timingStart, timingPhases,statusCode, respBody) {
  let start_time = new Date(timingStart).toLocaleString("zh-TW", {
    timeZone: "Asia/Taipei",
    hour12: false,
  });
  array_data = [];
  array_data.push(start_time+" ");

  var object_data = Object.entries(timingPhases);

  for (var i = 0; i < object_data.length; i++) {
    array_data.push(
      object_data[i][0] + ": " + (object_data[i][1] / 1000).toFixed(5) + " "
    );
  }

  let status_code = "statusCode: " +JSON.stringify(statusCode)+" ";
  array_data.push(status_code);

  let body = "body: " + JSON.stringify(respBody);
  array_data.push(body);
  return array_data;
}

// dig address
function dig_dns(data,host) {
  var dns = require("dns");
  dns.lookup(host, function (err, addresses, family) {
    dns_data = "host: " + host + " ip: " + addresses;
    logging(dir, data + " " + dns_data + "\r\n");
  });
}

//logging
function logging(log_dir, log_data) {
  if (fs.existsSync(log_dir)) {
    fs.appendFile(log_dir, log_data, (err) => {
      if (err) {
        console.error(err);
        return;
      }
    });
  } else {
    fs.writeFile(log_dir, log_data.toString(), function (err) {
      if (err) console.log(err);
      else console.log("create file and saved");
    });
  }
}

// send request
function req() {
  let error_time = new Date(Date.now()).toLocaleString("zh-TW", {
    timeZone: "Asia/Taipei",
    hour12: false,
  });
  requestPromise(options, (err, resp) => {
    if (!err) {

      data = parse_data(
        resp.timingStart,
        resp.timingPhases,
        resp.statusCode,
        resp.body
      );

      dig_dns(data,resp.request.host);

    } else {
      console.log("------------------- error request -------------------");
      console.log(error_time);
      console.log(err);
    }
  }).catch(function (error) {
    console.log("------------------- error -------------------");
    console.log(error_time);
    console.log(error);
  });
}

// request per second
setInterval(function () {
  req();
}, 1000);