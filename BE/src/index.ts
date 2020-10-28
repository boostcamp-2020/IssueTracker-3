import express from "express";
import index from "./route/index";
import auth from "./route/auth";
import milestone from "./route/milestone";
import label from "./route/label";
import issue from "./route/issue";
import event from "./route/event";

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
app.use("/label", label);
app.use("/issue", issue);
app.use("/event", event);

app.listen(4000, () => console.log("start"));
