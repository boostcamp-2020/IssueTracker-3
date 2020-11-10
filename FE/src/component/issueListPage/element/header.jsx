import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import "react-dropdown/style.css";
import LabelDropdown from "./labelDropdown";
import MilestoneDropdown from "./milestoneDropdown";

function IssueHeader(props) {
  const { setIssues, labels, milestones, originIssues } = props;
  const [condition, setCondition] = useState({ label: null, milestone: null });

  useEffect(() => {
    const filtered = originIssues
      .filter((issue) => {
        if (condition.label === null) return true;
        if (condition.label === "empty" && issue.labels.length === 0) return true;
        if (condition.label === "empty" && issue.labels.length !== 0) return false;
        let isIn = false;
        issue.labels.forEach((l) => {
          if (l.name === condition.label) isIn = true;
        });
        return isIn;
      })
      .filter((issue) => {
        if (condition.milestone === null) return true;
        if (condition.milestone === "empty" && issue.milestone.length === 0) return true;
        if (condition.milestone === "empty" && issue.milestone.length !== 0) return false;
        if (issue.milestone?.[0]?.name === condition.milestone) return true;
        return false;
      });
    setIssues(filtered);
  }, [condition]);
  return (
    <>
      <LabelDropdown labels={labels} setCondition={setCondition} condition={condition} />
      <MilestoneDropdown milestones={milestones} setCondition={setCondition} condition={condition} />
    </>
  );
}

export default hot(module)(IssueHeader);
