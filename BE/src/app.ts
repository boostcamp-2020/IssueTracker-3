import express, { Application } from "express";
import passport from "passport";
import session from "express-session";
import bodyParser from "body-parser";
import helmet from "helmet";

import index from "./route/index";
import auth from "./route/auth";
import milestone from "./route/milestone";
import label from "./route/label";
import issue from "./route/issue";
import event from "./route/event";

import Passport from "./passport/passport";

class App {
  private app: Application;

  private passportConfig: Passport;

  constructor(private port?: number | string) {
    this.app = express();
    this.settings();
    this.middleware();
    this.routes();
  }

  public async listen() {
    await this.app.listen(this.app.get("port"));
    console.info(`Server on port ${this.app.get(`port`)}`);
  }

  private settings() {
    this.app.set("port", process.env.PORT || this.port || 3000);
    this.passportConfig = new Passport();
  }

  private middleware() {
    this.app.use(helmet());
    this.app.use(bodyParser.json());
    this.app.use(bodyParser.urlencoded({ extended: false }));
    this.app.use(passport.initialize());
    this.app.use(
      session({
        secret: `@#@$MYSIGN#@$#$`,
        resave: false,
        saveUninitialized: true,
      })
    );
    this.app.use(passport.session());
    this.passportConfig.config();
  }

  private routes() {
    this.app.use("/", index);
    this.app.use("/auth", auth);
    this.app.use("/milestone", milestone);
    this.app.use("/label", label);
    this.app.use("/issue", issue);
    this.app.use("/event", event);
  }
}
export default App;
