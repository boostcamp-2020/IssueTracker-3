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
function IssueListPage(props) {
  const { user } = props;
  const [labels, setLabels] = useState([]);
  const [milestones, setMilestones] = useState([]);
  const [issues, setIssues] = useState([]);
  const [originIssues, setOriginIssues] = useState([]);
  const [users, setUsers] = useState([]);
  const [checked, setChecked] = useState([]);
  const [condition, setCondition] = useState({ state: 1, author: 0, assignee: 0, comment: 0 });
  useEffect(async () => {
    const response = await axiosApi("/label", "GET");
    setLabels(response.data);
  }, []);
  useEffect(async () => {
    const response = await axiosApi("/milestone", "GET");
    setMilestones(response.data);
  }, []);
  useEffect(async () => {
    const response = await axiosApi(
      `/issue/filter/state/${condition.state}/author/${condition.author}/assignee/${condition.assignee}/comment/${condition.comment}`,
      "GET"
    );
    setOriginIssues(response.data);
    setIssues(response.data);
  }, [condition]);
  useEffect(async () => {
    const response = await axiosApi("/auth/alluser", "GET");
    setUsers(response.data);
  }, []);
  console.log(localStorage.getItem("token"));
  alert(localStorage.getItem("token"));
  return (
    <StyledIssueListPage>
      <IssueHeader labels={labels} milestones={milestones} condition={condition} setCondition={setCondition} user={user} />
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
