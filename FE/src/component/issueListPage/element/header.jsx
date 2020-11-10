import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import "react-dropdown/style.css";
import LabelDropdown from "./labelDropdown";

function IssueHeader(props) {
  const { setIssues, labels, milestones, originIssues } = props;
  const [condition, setCondition] = useState({ label: null, milestone: null });
  const labelOption = labels.map((label) => {
    return { value: label.name, label: label.name };
  });
  labelOption.unshift({ label: "issue with no label", value: null });
  const milestoneOption = milestones.map((milestone) => {
    return { value: milestone.name, label: milestone.name };
  });
  milestoneOption.unshift({ label: "issue with no milestone", value: null });
  useEffect(() => {
    const filtered = originIssues
      .filter((issue) => {
        if (condition.label === null) return true;
        let isIn = false;
        issue.labels.forEach((l) => {
          if (l.name === condition.label) isIn = true;
        });
        return isIn;
      })
      .filter((issue) => {
        if (condition.milestone === null) return true;
        if (issue.milestone.name === condition.milestone) return true;
        return false;
      });
    setIssues(filtered);
  }, [condition]);
  return (
    <>
      <LabelDropdown labelOption={labelOption} setCondition={setCondition} condition={condition} />
    </>
  );
}

export default hot(module)(IssueHeader);
