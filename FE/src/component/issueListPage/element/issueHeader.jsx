import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import MoveToCreateIssueButton from "@component/issueListPage/buttons/moveToCreateIssueButton";
import MoveToLabelButton from "@component/labelListPage/buttons/moveToLabelButton";
import MoveToMilestoneButton from "@component/labelListPage/buttons/moveToMilestoneButton";

const Styled = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  width: 100%;
`;

function IsssueHeader(props) {
  const { labels, milestones } = props;
  return (
    <>
      <Styled>
        <MoveToLabelButton labels={labels} />
        <MoveToMilestoneButton milestones={milestones} />
        <MoveToCreateIssueButton />
      </Styled>
    </>
  );
}

export default hot(module)(IsssueHeader);
