import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledIssueDetailPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function IssueDetailPage() {
  return <StyledIssueDetailPage>IssueDetailPage</StyledIssueDetailPage>;
}

export default hot(module)(IssueDetailPage);
