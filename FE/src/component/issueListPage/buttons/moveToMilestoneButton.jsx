import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StyledMoveToMilestoneButton = styled.button`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function MoveToMilestoneButton() {
  return (
    <Link to="./milestonelist">
      <StyledMoveToMilestoneButton> 마일스톤 </StyledMoveToMilestoneButton>
    </Link>
  );
}

export default hot(module)(MoveToMilestoneButton);
