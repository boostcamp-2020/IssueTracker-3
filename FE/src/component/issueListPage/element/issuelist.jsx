import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import Issue from "@component/issueListPage/element/issue";

const StyledIssueList = styled.div`
  display: flex;
  width: 100%;
  border: 1px solid gray;
  margin: 5px;
  flex-direction: column;
`;

function IssueList(props) {
  const { issues, setChecked, checked } = props;
  return (
    <>
      <StyledIssueList>
        {issues?.map((issue, index) => (
          <Issue key={index} issue={issue} setChecked={setChecked} checked={checked} />
        ))}
      </StyledIssueList>
    </>
  );
}

export default hot(module)(IssueList);
