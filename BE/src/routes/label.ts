import express from "express";
import LabelController from "@controllers/label";

const router = express.Router();

router.get("/", LabelController.get);
router.post("/", LabelController.add);
router.patch("/", LabelController.edit);
router.delete("/", LabelController.del);
export = router;
