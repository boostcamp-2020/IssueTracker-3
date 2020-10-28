import mysql2 from "mysql2/promise";
import dotenv from "dotenv";
import path from "path";

dotenv.config({ path: path.join(__dirname, "../../.env") });

class DB {
  pool: any;

  constructor() {
    this.pool = mysql2.createPool({
      host: process.env.DATABASE_HOST,
      port: Number(process.env.DATABASE_PORT),
      user: process.env.DATABASE_USER,
      password: process.env.DATABASE_PASSWORD,
      database: process.env.DATABASE_NAME,
      connectionLimit: 10,
    });
  }

  connect() {
    this.pool.getConnection((err: Error) => {
      console.error(err);
    });
  }
}

const db = new DB();

export default db;
