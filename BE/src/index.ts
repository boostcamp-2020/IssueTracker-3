import express from "express";
import index from "./route/index";

class App {
  public application: express.Application;

  constructor() {
    this.application = express();
  }
}
const app = new App().application;

app.use("/", index);
app.listen(4000, () => console.log("start"));
