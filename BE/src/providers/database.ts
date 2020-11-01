import mysql2 from "mysql2/promise";
import dotenv from "dotenv";
import path from "path";

dotenv.config({ path: path.join(__dirname, "../../.env") });

class DB {
  pool: mysql2.Pool;

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

  async query<T>(str: string, params: T): Promise<any> {
    try {
      const result = await this.pool.query(str, params);
      return result;
    } catch (err) {
      return err;
    }
  }
}

const db = new DB();

export default db;
