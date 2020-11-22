import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StyledMoveToCreateIssueButton = styled.button`
  display: flex;
  border: 1px solid forestgreen;
  margin: 5px;
  color: white;
  border-radius: 5px;
  background-color: #33cc33;
`;
function MoveToCreateIssueButton() {
  return (
    <Link to="./issuecreate" style={{ textDecoration: "none" }}>
      <StyledMoveToCreateIssueButton> New issue </StyledMoveToCreateIssueButton>
    </Link>
  );
}

export default hot(module)(MoveToCreateIssueButton);
