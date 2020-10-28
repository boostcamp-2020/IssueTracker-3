import express, { Application } from "express";

import helmet from "helmet";

class App {
  private app: Application;

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
  }

  private middleware() {
    this.app.use(helmet());
  }

  private routes() {}
}
export default App;
