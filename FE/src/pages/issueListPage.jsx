import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import Header from "@component/issueListPage/element/header";
import MoveToCreateIssueButton from "../component/issueListPage/buttons/moveToCreateIssueButton";
import MoveToLabelButton from "../component/issueListPage/buttons/moveToLabelButton";
import MoveToMilestoneButton from "../component/issueListPage/buttons/moveToMilestoneButton";
import Issuelist from "../component/issueListPage/element/issuelist";
import axiosApi from "../util/axiosApi";

const StyledIssueListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  flex-direction: column;
`;
function IssueListPage() {
  const [labels, setLabels] = useState([]);
  const [milestones, setMilestones] = useState([]);
  const [issues, setIssues] = useState([]);
  useEffect(async () => {
    const response = await axiosApi("/label", "GET");
    setLabels(response.data);
  }, []);

  useEffect(async () => {
    const response = await axiosApi("/milestone", "GET");
    setMilestones(response.data);
  }, []);
  useEffect(async () => {
    const response = await axiosApi("/issue", "GET");
    setIssues(response.data);
  }, []);
  return (
    <StyledIssueListPage>
      IssueListPage
      <MoveToLabelButton labels={labels} setLabels={setLabels} />
      <MoveToMilestoneButton milestones={milestones} />
      <MoveToCreateIssueButton />
      <Header />
      <Issuelist issues={issues} setIssues={setIssues} />
    </StyledIssueListPage>
  );
}

export default hot(module)(IssueListPage);
