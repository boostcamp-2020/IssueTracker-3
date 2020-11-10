import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import MoveToCreateIssueButton from "../component/issueListPage/buttons/moveToCreateIssueButton";
import MoveToLabelButton from "../component/issueListPage/buttons/moveToLabelButton";
import MoveToMilestoneButton from "../component/issueListPage/buttons/moveToMilestoneButton";
import axiosApi from "../util/axiosApi";

const StyledIssueListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function IssueListPage() {
  const [labels, setLabels] = useState([]);
  const [milestones, setMilestones] = useState([]);
  useEffect(async () => {
    const response = await axiosApi("/label", "GET");
    setLabels(response.data);
  }, []);

  useEffect(async () => {
    const response = await axiosApi("/milestone", "GET");
    setMilestones(response.data);
  }, []);
  return (
    <StyledIssueListPage>
      IssueListPage
      <MoveToLabelButton labels={labels} setLabels={setLabels} />
      <MoveToMilestoneButton milestones={milestones} />
      <MoveToCreateIssueButton />
    </StyledIssueListPage>
  );
}

export default hot(module)(IssueListPage);
