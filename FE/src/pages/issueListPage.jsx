import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledIssueListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function IssueListPage() {
  return <StyledIssueListPage>IssueListPage</StyledIssueListPage>;
}

export default hot(module)(IssueListPage);
