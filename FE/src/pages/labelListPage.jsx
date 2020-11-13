import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledLabelListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function LabelListPage() {
  return <StyledLabelListPage>LabelListPage</StyledLabelListPage>;
}

export default hot(module)(LabelListPage);
