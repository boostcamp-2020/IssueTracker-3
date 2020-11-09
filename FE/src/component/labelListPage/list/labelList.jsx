import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledLabelList = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function LabelList() {
  return <StyledLabelList>LabelList</StyledLabelList>;
}

export default hot(module)(LabelList);
