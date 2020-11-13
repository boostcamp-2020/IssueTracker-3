import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledMilestoneListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function MilestoneListPage() {
  return <StyledMilestoneListPage>MilestoneListPage</StyledMilestoneListPage>;
}

export default hot(module)(MilestoneListPage);
