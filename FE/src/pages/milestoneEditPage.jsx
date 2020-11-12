import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledMilestoneEditPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function MilestoneEditPage() {
  return <StyledMilestoneEditPage>MilestoneEditPage</StyledMilestoneEditPage>;
}

export default hot(module)(MilestoneEditPage);
