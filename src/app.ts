import "reflect-metadata";
import express from "express";
import { User } from "./entities/user";
import AppDataSource from "./config";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import cors from "cors";
import dotenv from "dotenv";
import { Events } from "./entities/events";
const app = express();
app.use(express.json());
const port = 8000;
app.use(
  cors({
    origin: "*",
  })
);
dotenv.config();
app.post("/registration", async (req, resp) => {
  const userRepo = AppDataSource.getRepository(User);
  const emailCheck = await userRepo.findOne({
    where: { email: req.body.email },
  });
  if (!emailCheck) {
    const hashedPassword = await bcrypt.hash(req.body.password, 12);
    let user: User = new User();
    user = { ...req.body };
    user.password = hashedPassword;
    let userInserted = await userRepo.save(user);
    const id = userInserted.user_id;
    let token = jwt.sign(
      { id },
      process.env.TOKEN_SECRET || "",
      { expiresIn: "2h" },
      (error, token) => {
        if (error) {
          resp.send({ userInserted: "Cant Insert the User" });
        } else resp.send(JSON.stringify({ auth: token, id: user.user_id }));
      }
    );
  } else {
    resp.json({ result: "User already exists" });
  }
});

app.post("/login", async (req, resp) => {
  const userRepo = AppDataSource.getRepository(User);
  let user = await userRepo.findOne({ where: { email: req.body.email } });
  if (user) {
    const match = await bcrypt.compare(req.body.password, user!.password);
    if (match) {
      const id = user.user_id;
      jwt.sign(
        { id },
        process.env.TOKEN_SECRET || "",
        { expiresIn: "2h" },
        (error, token) => {
          if (error) {
            resp.send(JSON.stringify({ user: "user not found" }));
          }
          resp.send(
            JSON.stringify({ auth: token, role: user?.role, id: user?.user_id })
          );
          return;
        }
      );
    }
  } else {
    resp.send({ user: "Please login" });
  }
});

app.get("/events/:id", async (req, resp) => {
  const eventRepo = AppDataSource.getRepository(Events);
  if (req.params.id) {
    console.log(req.params.id);
    const events = await eventRepo.findOne({
      where: { event_id: req.params.id },
    });
    resp.json(events);
  }
});

app.get("/events", async (req, resp) => {
  const eventRepo = AppDataSource.getRepository(Events);
  const events = await eventRepo.find();
  resp.json(events);
});

app.get("/events_org/:user_id", async (req, resp) => {
  const eventRepo = AppDataSource.getRepository(Events);
  const events = await eventRepo.find({
    where: { user_id: req.params.user_id },
  });
  resp.json(events);
});

app.post("/events/:user_id", async (req, resp) => {
  const eventRepo = AppDataSource.getRepository(Events);
  let event = new Events();
  event = { ...req.body };
  event.user_id = req.params.user_id;
  const saved_event = await eventRepo.save(event);
  resp.json(saved_event);
});

AppDataSource.initialize()
  .then(() => {
    app.listen(port, () => {
      console.log(`application is running on port ${port}.`);
    });
  })
  .catch((err) => console.log("error", err));
