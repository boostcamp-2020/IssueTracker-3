import express from "express";
import passport from "passport";
import session from "express-session";
import bodyParser from "body-parser";

import index from "./route/index";
import auth from "./route/auth";
import milestone from "./route/milestone";
import label from "./route/label";
import issue from "./route/issue";
import event from "./route/event";

import Passport from "./passport/passport";

class App {
  public application: express.Application;

  constructor() {
    this.application = express();
  }
}
const app = new App().application;
const passportConfig: Passport = new Passport();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(passport.initialize());
app.use(passport.session());
app.use(
  session({
    secret: `@#@$MYSIGN#@$#$`,
    resave: false,
    saveUninitialized: true,
  })
);
passportConfig.config();

app.use("/", index);
app.use("/auth", auth);
app.use("/milestone", milestone);
app.use("/label", label);
app.use("/issue", issue);
app.use("/event", event);

app.listen(4000, () => console.log("start"));
