import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import MoveToCreateIssueButton from "../component/issueListPage/buttons/moveToCreateIssueButton";
import MoveToLabelButton from "../component/issueListPage/buttons/moveToLabelButton";
import MoveToMilestoneButton from "../component/issueListPage/buttons/moveToMilestoneButton";

const StyledIssueListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function IssueListPage() {
  return <StyledIssueListPage>IssueListPage<MoveToCreateIssueButton/><MoveToLabelButton/></StyledIssueListPage>;
}

export default hot(module)(IssueListPage);
