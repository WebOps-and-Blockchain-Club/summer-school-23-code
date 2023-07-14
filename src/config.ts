import { DataSource } from "typeorm";
import Tables from "./entities";
import dotenv from "dotenv";
dotenv.config();
const AppDataSource = new DataSource({
  type: "postgres",
  host: "localhost",
  port: 5433,
  username: "postgres",
  password: "rasagnya",
  database: "ss",
  entities: Tables,
  synchronize: true,
  logging: true,
});

export default AppDataSource;
