import express from "express";
import LabelController from "@controllers/label";

const router = express.Router();

router.get("/", LabelController.getLabel);
router.post("/", LabelController.postLabel);
router.patch("/", LabelController.updateLabel);
export = router;
