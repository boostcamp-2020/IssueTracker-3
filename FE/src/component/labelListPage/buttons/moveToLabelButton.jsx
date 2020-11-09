import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StyledMoveToLabelButton = styled.button`
  display: flex;
  border: 1px solid gray;
  background-color: blue;
  color: white;
  font-weight: bold;
  margin: 5px 0px;
  border-top-left-radius: 4px;
  border-bottom-left-radius: 4px;
`;
function MoveToLabelButton() {
  return (
    <Link to="./labellist" style={{ textDecoration: "none" }}>
      <StyledMoveToLabelButton>라벨</StyledMoveToLabelButton>
    </Link>
  );
}

export default hot(module)(MoveToLabelButton);
