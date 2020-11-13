import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import LabelDropdown from "./labelDropdown";
import MilestoneDropdown from "./milestoneDropdown";
import UserDropdown from "./userDropdown";

const Styled = styled.div`
  display: flex;
  width: 100%;
  justify-content: flex-end;
`;

function IssueFilter(props) {
  const { setIssues, labels, milestones, originIssues, users } = props;
  const [condition, setCondition] = useState({ label: "default", milestone: "default", user: "default" });

  useEffect(() => {
    const filtered = originIssues
      .filter((issue) => {
        if (condition.label === "default") return true;
        if (condition.label === "empty" && issue.labels.length === 0) return true;
        if (condition.label === "empty" && issue.labels.length !== 0) return false;
        let isIn = false;
        issue.labels.forEach((l) => {
          if (l.name === condition.label) isIn = true;
        });
        return isIn;
      })
      .filter((issue) => {
        if (condition.milestone === "default") return true;
        if (condition.milestone === "empty" && issue.milestone.length === 0) return true;
        if (condition.milestone === "empty" && issue.milestone.length !== 0) return false;
        if (issue.milestone?.[0]?.name === condition.milestone) return true;
        return false;
      })
      .filter((issue) => {
        if (condition.user === "default") return true;
        if (issue.user_id === condition.user) return true;
        return false;
      });
    setIssues(filtered);
  }, [condition]);
  return (
    <>
      <Styled>
        <LabelDropdown labels={labels} setCondition={setCondition} condition={condition} />
        <MilestoneDropdown milestones={milestones} setCondition={setCondition} condition={condition} />
        <UserDropdown users={users} setCondition={setCondition} condition={condition} />
      </Styled>
    </>
  );
}

export default hot(module)(IssueFilter);
