import express from "express";
import TagController from "../controllers/tag";

const router = express.Router();
router.get("/", TagController.get);
router.patch("/", TagController.edit);
export = router;
