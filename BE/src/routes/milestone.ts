import express from "express";
import Controller from "../controllers/milestone";

const router = express.Router();

router.get("/", Controller.get);
router.post("/", Controller.add);
router.patch("/", Controller.edit);
router.delete("/", Controller.del);
export = router;
