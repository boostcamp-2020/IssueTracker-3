import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledIssue = styled.div`
  border: 1px solid gray;
  border-radius: 1px;
`;

const Issue = (props) => {
  const { issue } = props;
  return (
    <StyledIssue>
      <div>{issue.title}</div>
    </StyledIssue>
  );
};

export default hot(module)(Issue);
