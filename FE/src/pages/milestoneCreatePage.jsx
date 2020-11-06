import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledMilestoneCreatePage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function MilestoneCreatePage() {
  return <StyledMilestoneCreatePage>MilestoneCreatePage</StyledMilestoneCreatePage>;
}

export default hot(module)(MilestoneCreatePage);
