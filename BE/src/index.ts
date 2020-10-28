import express from "express";
import index from "./route/index";
import auth from "./route/auth";
import milestone from "./route/milestone";

class App {
  public application: express.Application;

  constructor() {
    this.application = express();
  }
}
const app = new App().application;

app.use("/", index);
app.use("/auth", auth);
app.use("/milestone", milestone);

app.listen(4000, () => console.log("start"));
