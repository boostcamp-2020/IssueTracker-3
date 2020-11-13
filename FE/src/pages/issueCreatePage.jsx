import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledIssueCreatePage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function IssueCreatePage() {
  return <StyledIssueCreatePage>IssueCreatePage</StyledIssueCreatePage>;
}

export default hot(module)(IssueCreatePage);
