import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import IssueHeader from "@component/issueListPage/element/issueHeader";
import Issuelist from "../component/issueListPage/element/issuelist";
import axiosApi from "../util/axiosApi";
import IssueFilter from "../component/issueListPage/element/issueFilter";

const StyledIssueListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  flex-direction: column;
  width: 100%;
`;
function IssueListPage() {
  const [labels, setLabels] = useState([]);
  const [milestones, setMilestones] = useState([]);
  const [issues, setIssues] = useState([]);
  const [originIssues, setoriginIssues] = useState([]);
  const [users, setUsers] = useState([]);
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
    setoriginIssues(response.data);
  }, []);
  useEffect(async () => {
    const response = await axiosApi("/auth/alluser", "GET");
    setUsers(response.data);
  }, []);
  return (
    <StyledIssueListPage>
      <IssueHeader labels={labels} milestones={milestones} />
      <IssueFilter labels={labels} milestones={milestones} setIssues={setIssues} originIssues={originIssues} issues={issues} users={users} />
      <Issuelist issues={issues} setChecked={setChecked} />
    </StyledIssueListPage>
  );
}

export default hot(module)(IssueListPage);
