"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("reflect-metadata");
const express_1 = __importDefault(require("express"));
const user_1 = require("./entities/user");
const config_1 = __importDefault(require("./config"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const bcrypt_1 = __importDefault(require("bcrypt"));
const cors_1 = __importDefault(require("cors"));
const dotenv_1 = __importDefault(require("dotenv"));
const events_1 = require("./entities/events");
const app = (0, express_1.default)();
app.use(express_1.default.json());
const port = 8000;
app.use((0, cors_1.default)({
    origin: "*",
}));
dotenv_1.default.config();
app.post("/registration", (req, resp) => __awaiter(void 0, void 0, void 0, function* () {
    const userRepo = config_1.default.getRepository(user_1.User);
    const emailCheck = yield userRepo.findOne({
        where: { email: req.body.email },
    });
    if (!emailCheck) {
        const hashedPassword = yield bcrypt_1.default.hash(req.body.password, 12);
        let user = new user_1.User();
        user = Object.assign({}, req.body);
        user.password = hashedPassword;
        let userInserted = yield userRepo.save(user);
        const id = userInserted.user_id;
        jsonwebtoken_1.default.sign({ id }, process.env.TOKEN_SECRET || "", { expiresIn: "2h" }, (error, token) => {
            if (error) {
                resp.json({ userInserted: "Cant Intsert the User" });
            }
            resp.json({ auth: token });
            return;
        });
        resp.send("user Registered");
    }
    else {
        resp.json({ result: "User already exists" });
    }
}));
app.get("/login", (req, resp) => __awaiter(void 0, void 0, void 0, function* () {
    const userRepo = config_1.default.getRepository(user_1.User);
    let user = yield userRepo.findOne({ where: { email: req.body.email } });
    if (user) {
        const match = yield bcrypt_1.default.compare(req.body.password, user.password);
        if (match) {
            const id = user.user_id;
            jsonwebtoken_1.default.sign({ id }, process.env.TOKEN_SECRET || "", { expiresIn: "2h" }, (error, token) => {
                if (error) {
                    resp.json({ user: "user not found" });
                }
                resp.json({ auth: token, role: user === null || user === void 0 ? void 0 : user.role });
                return;
            });
        }
    }
    else {
        resp.json({ user: "Please register" });
    }
}));
app.get("/events/:id", (req, resp) => __awaiter(void 0, void 0, void 0, function* () {
    const eventRepo = config_1.default.getRepository(events_1.Events);
    if (req.params.id) {
        console.log(req.params.id);
        const events = yield eventRepo.findOne({
            where: { event_id: req.params.id },
        });
        resp.json(events);
    }
}));
app.get("/events", (req, resp) => __awaiter(void 0, void 0, void 0, function* () {
    const eventRepo = config_1.default.getRepository(events_1.Events);
    const events = yield eventRepo.find();
    resp.json(events);
}));
app.get("/events_org/:user_id", (req, resp) => __awaiter(void 0, void 0, void 0, function* () {
    const eventRepo = config_1.default.getRepository(events_1.Events);
    const events = yield eventRepo.find({
        where: { user_id: req.params.user_id },
    });
    resp.json(events);
}));
app.get("/user/:user_id", (req, resp) => __awaiter(void 0, void 0, void 0, function* () {
    const userRepo = config_1.default.getRepository(user_1.User);
    const user = yield userRepo.find({ where: { user_id: req.params.user_id } });
    resp.json(user);
}));
app.post("/events/:user_id", (req, resp) => __awaiter(void 0, void 0, void 0, function* () {
    const eventRepo = config_1.default.getRepository(events_1.Events);
    let event = new events_1.Events();
    event = Object.assign({}, req.body);
    event.user_id = req.params.user_id;
    const saved_event = yield eventRepo.save(event);
    resp.json(saved_event);
}));
config_1.default.initialize()
    .then(() => {
    app.listen(port, () => {
        console.log(`application is running on port ${port}.`);
    });
})
    .catch((err) => console.log("error", err));
