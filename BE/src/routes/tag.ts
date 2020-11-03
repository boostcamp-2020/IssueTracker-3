import express from "express";
import TagController from "../controllers/tag";

const router = express.Router();
router.post("/", TagController.add);
router.delete("/", TagController.del);
export = router;
