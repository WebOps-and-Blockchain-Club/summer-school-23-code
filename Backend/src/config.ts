import { DataSource } from "typeorm";
import Tables from "./entities";
import dotenv from "dotenv";
dotenv.config();
const AppDataSource = new DataSource({
  type: "postgres",
  host: "localhost",
  port: 5433,
  username: process.env.POSTGRES_USERNAME,
  password: process.env.POSTGRES_PASSWORD,
  database: "ss",
  entities: Tables,
  synchronize: true,
  logging: true,
});

export default AppDataSource;
