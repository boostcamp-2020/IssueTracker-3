import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledLabelFilter = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function LabelFilter() {
  return (
    <StyledLabelFilter>
      StyledLabelFilter<input></input>
    </StyledLabelFilter>
  );
}

export default hot(module)(LabelFilter);
