const express = require("express");
const app = express();
const path = require("path");
const cp = require("child_process");

app.use(express.static(path.resolve("./static")))

for (let i = 0; i < 4; i++) {
  cp.spawn(`${i + 1}.exe`, { cwd: path.resolve(`./static/${i + 1}`) });
}

app.listen(8182);