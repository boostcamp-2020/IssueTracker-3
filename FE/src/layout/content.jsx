import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledContent = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function Content() {
  return <StyledContent>Content</StyledContent>;
}

export default hot(module)(Content);
