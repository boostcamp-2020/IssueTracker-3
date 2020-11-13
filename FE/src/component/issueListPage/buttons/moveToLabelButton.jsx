import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StyledMoveToLabelButton = styled.button`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function MoveToLabelButton() {
  return (
    <Link to="./labellist">
      <StyledMoveToLabelButton> 라벨 </StyledMoveToLabelButton>
    </Link>
  );
}

export default hot(module)(MoveToLabelButton);
