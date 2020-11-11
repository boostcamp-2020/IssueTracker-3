import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import IssueHeader from "@component/issueListPage/element/issueHeader";
import Issuelist from "../component/issueListPage/element/issuelist";
import axiosApi from "../util/axiosApi";
import IssueFilter from "../component/issueListPage/element/issueFilter";
import CheckFilter from "../component/issueListPage/element/checkFilter";

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
  const [originIssues, setOriginIssues] = useState([]);
  const [users, setUsers] = useState([]);
  const [checked, setChecked] = useState([]);
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
    const openIssue = response.data.filter((issue) => {
      return issue.state == 1;
    });
    setOriginIssues(response.data);
    setIssues(openIssue);
  }, []);
  useEffect(async () => {
    const response = await axiosApi("/auth/alluser", "GET");
    setUsers(response.data);
  }, []);
  return (
    <StyledIssueListPage>
      <IssueHeader labels={labels} milestones={milestones} />
      {checked.length === 0 ? (
        <IssueFilter labels={labels} milestones={milestones} setIssues={setIssues} originIssues={originIssues} issues={issues} users={users} />
      ) : (
        <CheckFilter checked={checked} setOriginIssues={setOriginIssues} />
      )}
      <Issuelist issues={issues} setChecked={setChecked} checked={checked} />
    </StyledIssueListPage>
  );
}

export default hot(module)(IssueListPage);
