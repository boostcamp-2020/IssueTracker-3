import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StyledMoveToCreateIssueButton = styled.button`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function MoveToCreateIssueButton() {
  return (
    <Link to="./issuecreate">
      <StyledMoveToCreateIssueButton> New issue </StyledMoveToCreateIssueButton>
    </Link>
  );
}

export default hot(module)(MoveToCreateIssueButton);
